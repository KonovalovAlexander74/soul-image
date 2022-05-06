import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soul_image/core/constants/network.dart';
import 'package:soul_image/core/error/exceptions.dart';
import 'package:soul_image/features/home/data/models/image_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ImageModel>> getCuratedImages(int page);
  Future<List<ImageModel>> getImagesWithParams({
    required int page,
    required String query,
    String? color,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<ImageModel>> getCuratedImages(int page) async {
    List<ImageModel> images = [];

    final uri = Uri.parse('$hostPath/curated?per_page=$perPage&page=$page');
    final response = await http.get(uri, headers: apiKey);

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      images = (responseJson['photos'] as List)
          .map((image) => ImageModel.fromMap(image))
          .toList();

      return images;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ImageModel>> getImagesWithParams({
    required int page,
    required String query,
    String? color,
  }) async {
    List<ImageModel> images = [];

    var uriString =
        '$hostPath/search?per_page=$perPage&page=$page&query=$query';
    if (color != null) {
      uriString += '&color=$color';
    }

    final uri = Uri.parse(uriString);
    final response = await http.get(uri, headers: apiKey);

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      images = (responseJson['photos'] as List)
          .map((image) => ImageModel.fromMap(image))
          .toList();

      return images;
    } else {
      throw ServerException();
    }
  }
}
