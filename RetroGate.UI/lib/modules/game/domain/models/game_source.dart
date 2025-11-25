enum GameSource {
  available,
  installed,
}

extension GameSourceExtension on GameSource {
  GameSource fromProto(int value) {
    return GameSource.values.firstWhere((e) => e.index == value,
        orElse: () => GameSource.available);
  }
}