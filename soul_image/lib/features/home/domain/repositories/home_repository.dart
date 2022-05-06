import 'package:soul_image/features/home/domain/entities/image.dart';

abstract class HomeRepository {
  Future<List<ImageEntity>> getCuratedImages(int page);
  Future<List<ImageEntity>> getSearchedImages({
    required int page,
    required String query,
    String? color,
  });
}
