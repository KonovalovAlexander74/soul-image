import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:soul_image/features/home/domain/entities/image_url.dart';

// TODO: Rewrite to/from Json
class ImageUrlModel extends Equatable {
  final String original;
  final String medium;
  final String portrait;
  final String landscape;
  final String tiny;
  final String small;

  const ImageUrlModel({
    required this.original,
    required this.medium,
    required this.portrait,
    required this.landscape,
    required this.tiny,
    required this.small,
  });

  ImageUrlEntity toEntity() => ImageUrlEntity(
        original: original,
        landscape: landscape,
        medium: medium,
        portrait: portrait,
        tiny: tiny,
        small: small,
      );

  factory ImageUrlModel.fromEntity(ImageUrlEntity entity) => ImageUrlModel(
        original: entity.original,
        landscape: entity.landscape,
        medium: entity.medium,
        portrait: entity.portrait,
        tiny: entity.tiny,
        small: entity.small,
      );

  @override
  List<Object> get props {
    return [
      original,
      medium,
      portrait,
      landscape,
      tiny,
      small,
    ];
  }

  ImageUrlModel copyWith({
    String? original,
    String? medium,
    String? portrait,
    String? landscape,
    String? tiny,
    String? small,
  }) {
    return ImageUrlModel(
      original: original ?? this.original,
      medium: medium ?? this.medium,
      portrait: portrait ?? this.portrait,
      landscape: landscape ?? this.landscape,
      tiny: tiny ?? this.tiny,
      small: small ?? this.small,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'original': original});
    result.addAll({'medium': medium});
    result.addAll({'portrait': portrait});
    result.addAll({'landscape': landscape});
    result.addAll({'tiny': tiny});
    result.addAll({'small': small});

    return result;
  }

  factory ImageUrlModel.fromMap(Map<String, dynamic> map) {
    return ImageUrlModel(
      original: map['original'] ?? '',
      medium: map['medium'] ?? '',
      portrait: map['portrait'] ?? '',
      landscape: map['landscape'] ?? '',
      tiny: map['tiny'] ?? '',
      small: map['small'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageUrlModel.fromJson(String source) =>
      ImageUrlModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ImageUrlModel(original: $original, medium: $medium, portrait: $portrait, landscape: $landscape, tiny: $tiny, small: $small)';
  }
}
