import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:soul_image/core/constants/network.dart';
import 'package:soul_image/core/error/exceptions.dart';
import 'package:soul_image/features/home/data/models/image_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<ImageModel>> getCuratedImages(int page);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  @override
  Future<List<ImageModel>> getCuratedImages(int page) async {
    List<ImageModel> images = [];

    final uri = Uri.parse('$hostPath/curated?per_page=20&page=$page');
    final response = await http.get(uri, headers: apiKey);

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      images = (responseJson['photos'] as List)
          .map((e) => ImageModel.fromMap(e))
          .toList();
      return images;
    } else {
      throw ServerException();
    }
  }
}
