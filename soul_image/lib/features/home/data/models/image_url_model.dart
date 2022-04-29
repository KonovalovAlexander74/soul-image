import 'dart:convert';

import 'package:soul_image/features/home/domain/entities/image_url.dart';

// TODO: Equatable. rewrite to/from Json
class ImageUrlModel {
  final String original;
  final String tiny;
  final String small;
  ImageUrlModel({
    required this.original,
    required this.tiny,
    required this.small,
  });

  ImageUrlModel copyWith({
    String? original,
    String? tiny,
    String? small,
  }) {
    return ImageUrlModel(
      original: original ?? this.original,
      tiny: tiny ?? this.tiny,
      small: small ?? this.small,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'original': original});
    result.addAll({'tiny': tiny});
    result.addAll({'small': small});

    return result;
  }

  factory ImageUrlModel.fromMap(Map<String, dynamic> map) {
    return ImageUrlModel(
      original: map['original'] ?? '',
      tiny: map['tiny'] ?? '',
      small: map['small'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageUrlModel.fromJson(String source) =>
      ImageUrlModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'ImageUrl(original: $original, tiny: $tiny, small: $small)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageUrlModel &&
        other.original == original &&
        other.tiny == tiny &&
        other.small == small;
  }

  @override
  int get hashCode => original.hashCode ^ tiny.hashCode ^ small.hashCode;

  ImageUrlEntity toEntity() => ImageUrlEntity(
        original: original,
        tiny: tiny,
        small: small,
      );

  factory ImageUrlModel.fromEntity(ImageUrlEntity entity) => ImageUrlModel(
        original: entity.original,
        tiny: entity.tiny,
        small: entity.small,
      );
}
