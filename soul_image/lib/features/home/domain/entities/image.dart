import 'package:soul_image/features/home/domain/entities/image_url.dart';

class ImageEntity {
  final String photographer;
  final String description;
  final String avgColor;
  final ImageUrlEntity url;

  const ImageEntity({
    required this.photographer,
    required this.description,
    required this.avgColor,
    required this.url,
  });
}
