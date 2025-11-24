enum InstallerProgressState {
  idle,
  downloading,
  extracting,
  creatingShortcut,
  paused,
  completed,
  failed,
}

class InstallerProgress {
  final String gameId;
  final InstallerProgressState state;
  final int percentage;
  final int speedInKbPerSec;

  const InstallerProgress({
    required this.gameId,
    required this.state,
    required this.percentage,
    required this.speedInKbPerSec,
  });

  factory InstallerProgress.fromProto(dynamic proto) {
    // Map proto enum to domain enum
    InstallerProgressState mapState(int protoState) {
      switch (protoState) {
        case 0:
          return InstallerProgressState.idle;
        case 1:
          return InstallerProgressState.downloading;
        case 2:
          return InstallerProgressState.extracting;
        case 3:
          return InstallerProgressState.creatingShortcut;
        case 4:
          return InstallerProgressState.paused;
        case 5:
          return InstallerProgressState.completed;
        case 6:
          return InstallerProgressState.failed;
        default:
          return InstallerProgressState.idle;
      }
    }

    return InstallerProgress(
      gameId: proto.gameId,
      state: mapState(proto.state.value),
      percentage: proto.percentage,
      speedInKbPerSec: proto.speedInKbPerSec,
    );
  }

  String get stateLabel {
    switch (state) {
      case InstallerProgressState.idle:
        return 'Idle';
      case InstallerProgressState.downloading:
        return 'Downloading';
      case InstallerProgressState.extracting:
        return 'Extracting';
      case InstallerProgressState.creatingShortcut:
        return 'Creating Shortcut';
      case InstallerProgressState.paused:
        return 'Paused';
      case InstallerProgressState.completed:
        return 'Completed';
      case InstallerProgressState.failed:
        return 'Failed';
    }
  }

  String get speedFormatted {
    if (speedInKbPerSec == 0) return '0 KB/s';
    if (speedInKbPerSec < 1024) return '$speedInKbPerSec KB/s';
    final mbPerSec = speedInKbPerSec / 1024;
    return '${mbPerSec.toStringAsFixed(2)} MB/s';
  }

  bool get isInProgress {
    return state == InstallerProgressState.downloading ||
        state == InstallerProgressState.extracting ||
        state == InstallerProgressState.creatingShortcut;
  }

  bool get isCompleted => state == InstallerProgressState.completed;
  bool get isFailed => state == InstallerProgressState.failed;
  bool get isPaused => state == InstallerProgressState.paused;
}
