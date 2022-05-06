class ImageUrlEntity {
  final String original;
  final String medium;
  final String portrait;
  final String landscape;
  final String tiny;
  final String small;

  String fromImageSize(ImageSize size) {
    switch (size) {
      case ImageSize.original:
        return original;
      case ImageSize.medium:
        return medium;
      case ImageSize.portrait:
        return portrait;
      case ImageSize.landscape:
        return landscape;
      case ImageSize.tiny:
        return tiny;
      case ImageSize.small:
        return small;
      default:
        return original;
    }
  }

  const ImageUrlEntity({
    required this.original,
    required this.medium,
    required this.portrait,
    required this.landscape,
    required this.tiny,
    required this.small,
  });
}

enum ImageSize {
  original,
  medium,
  portrait,
  landscape,
  tiny,
  small,
}
