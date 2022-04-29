import 'package:soul_image/features/home/domain/entities/image.dart';

abstract class HomeRepository {
  Future<List<ImageEntity>> getCuratedImages(int page);
}
