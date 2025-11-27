import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/models/installer_progress.dart';
import '../../domain/repositories/installer_repository.dart';
import '../datasources/installer_grpc_datasource.dart';

class InstallerRepositoryImpl implements InstallerRepository {
  final InstallerGrpcDataSource _dataSource;
  StreamSubscription? _eventSubscription;
  StreamController<InstallerProgress>? _progressController;
  bool _isSubscribed = false;
  int _reconnectAttempts = 0;
  static const int _maxReconnectAttempts = 5;
  static const Duration _reconnectDelay = Duration(seconds: 2);

  InstallerRepositoryImpl(this._dataSource);

  @override
  Future<String> install({
    required String gameId,
    bool replace = false,
    bool restartSteam = false,
  }) async {
    return await _dataSource.install(
      gameId: gameId,
      replace: replace,
      restartSteam: restartSteam,
    );
  }

  @override
  Future<void> uninstall(String id) {
    return _dataSource.uninstall(
      gameId: id,
    );
  }

  @override
  Future<void> cancel(String id) async {
    await _dataSource.cancel(id);
  }

  @override
  Stream<InstallerProgress> subscribeToProgress() {
    // Return existing stream if already subscribed
    if (_progressController != null && !_progressController!.isClosed) {
      debugPrint('[InstallerRepository] Returning existing progress stream');
      return _progressController!.stream;
    }

    debugPrint('[InstallerRepository] Creating new progress stream with auto-reconnect');
    _progressController = StreamController<InstallerProgress>.broadcast(
      onListen: () {
        debugPrint('[InstallerRepository] Stream listener added, starting subscription');
        _subscribe();
      },
      onCancel: () {
        debugPrint('[InstallerRepository] All stream listeners cancelled');
        _cleanup();
      },
    );

    return _progressController!.stream;
  }

  void _subscribe() {
    if (_isSubscribed) {
      debugPrint('[InstallerRepository] Already subscribed, skipping');
      return;
    }

    debugPrint('[InstallerRepository] Subscribing to installer events...');
    _isSubscribed = true;
    _reconnectAttempts = 0;

    try {
      final eventStream = _dataSource.subscribeEvents();
      
      _eventSubscription = eventStream.listen(
        (event) {
          _reconnectAttempts = 0; // Reset on successful message
          
          if (event.hasProgressChanged()) {
            final progress = InstallerProgress.fromProto(event.progressChanged);
            debugPrint(
              '[InstallerRepository] Progress: ${progress.gameId} - '
              '${progress.stateLabel} ${progress.percentage}% @ ${progress.speedFormatted}'
            );
            _progressController?.add(progress);
          } else {
            debugPrint('[InstallerRepository] Received unknown event type');
          }
        },
        onError: (error) {
          debugPrint('[InstallerRepository] Stream error: $error');
          _handleDisconnection();
        },
        onDone: () {
          debugPrint('[InstallerRepository] Stream closed by server');
          _handleDisconnection();
        },
        cancelOnError: false,
      );

      debugPrint('[InstallerRepository] ✓ Successfully subscribed to installer events');
    } catch (e) {
      debugPrint('[InstallerRepository] ✗ Failed to subscribe: $e');
      _handleDisconnection();
    }
  }

  void _handleDisconnection() {
    _isSubscribed = false;
    _eventSubscription?.cancel();
    _eventSubscription = null;

    if (_progressController == null || _progressController!.isClosed) {
      debugPrint('[InstallerRepository] Stream controller closed, not reconnecting');
      return;
    }

    if (_reconnectAttempts >= _maxReconnectAttempts) {
      debugPrint(
        '[InstallerRepository] Max reconnect attempts ($_maxReconnectAttempts) reached, giving up'
      );
      _progressController?.addError(
        Exception('Failed to maintain connection to installer service')
      );
      return;
    }

    _reconnectAttempts++;
    debugPrint(
      '[InstallerRepository] Reconnecting in ${_reconnectDelay.inSeconds}s '
      '(attempt $_reconnectAttempts/$_maxReconnectAttempts)...'
    );

    Future.delayed(_reconnectDelay, () {
      if (_progressController != null && !_progressController!.isClosed) {
        _subscribe();
      }
    });
  }

  void _cleanup() {
    debugPrint('[InstallerRepository] Cleaning up subscriptions');
    _isSubscribed = false;
    _eventSubscription?.cancel();
    _eventSubscription = null;
    _progressController?.close();
    _progressController = null;
    _reconnectAttempts = 0;
  }

  void dispose() {
    debugPrint('[InstallerRepository] Disposing repository');
    _cleanup();
  }
}
