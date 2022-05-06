import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:soul_image/features/home/data/models/image_url_model.dart';
import 'package:soul_image/features/home/domain/entities/image.dart';

// TODO: Equatable. rewrite to/from Json
class ImageModel extends Equatable {
  final String photographer;
  final String description;
  final String avgColor;
  final ImageUrlModel imageUrl;

  const ImageModel({
    required this.photographer,
    required this.description,
    required this.avgColor,
    required this.imageUrl,
  });

  ImageModel copyWith({
    String? photographer,
    String? description,
    String? avgColor,
    ImageUrlModel? imageUrl,
  }) {
    return ImageModel(
      photographer: photographer ?? this.photographer,
      description: description ?? this.description,
      avgColor: avgColor ?? this.avgColor,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'photographer': photographer});
    result.addAll({'alt': description});
    result.addAll({'avg_color': avgColor});
    result.addAll({'src': imageUrl.toMap()});

    return result;
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      photographer: map['photographer'] ?? '',
      description: map['alt'] ?? '',
      avgColor: map['avg_color'] ?? '',
      imageUrl: ImageUrlModel.fromMap(map['src']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ImageModel(photographer: $photographer, description: $description, imageUrl: $imageUrl)';

  ImageEntity toEntity() => ImageEntity(
        photographer: photographer,
        description: description,
        avgColor: avgColor,
        url: imageUrl.toEntity(),
      );

  factory ImageModel.fromEntity(ImageEntity entity) => ImageModel(
        photographer: entity.photographer,
        description: entity.description,
        avgColor: entity.avgColor,
        imageUrl: ImageUrlModel.fromEntity(entity.url),
      );

  @override
  List<Object?> get props => [photographer, description, avgColor, imageUrl];
}
