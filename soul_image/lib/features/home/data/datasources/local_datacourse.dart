import 'package:shared_preferences/shared_preferences.dart';
import 'package:soul_image/core/error/exceptions.dart';
import 'package:soul_image/features/home/data/models/image_model.dart';

abstract class HomeLocalDataSource {
  Future<List<ImageModel>> getImagesFromCache();
  Future<void> cacheImages(List<ImageModel> images);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  HomeLocalDataSourceImpl({required this.sharedPreferences});

  final SharedPreferences sharedPreferences;

  static const String _cachedImagesKey = 'cached_images';

  @override
  Future<List<ImageModel>> getImagesFromCache() async {
    final response = sharedPreferences.getStringList(_cachedImagesKey);

    if (response != null) {
      return Future.value(
        response.map((imageJson) => ImageModel.fromJson(imageJson)).toList(),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheImages(List<ImageModel> images) {
    final List<String> imagesJson = images.map((e) => e.toJson()).toList();

    sharedPreferences.setStringList(_cachedImagesKey, imagesJson);
    return Future.value();
  }
}
