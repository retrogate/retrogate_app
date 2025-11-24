class GameImages {
  final String heroUrl;
  final String posterUrl;
  final String logoUrl;

  GameImages({
    required this.heroUrl,
    required this.posterUrl,
    required this.logoUrl,
  });

  factory GameImages.fromProto(dynamic proto) {
    return GameImages(
      heroUrl: proto.heroUrl,
      posterUrl: proto.posterUrl,
      logoUrl: proto.logoUrl,
    );
  }
}
