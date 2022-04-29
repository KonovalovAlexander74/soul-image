import 'package:soul_image/core/error/exceptions.dart';
import 'package:soul_image/core/network/network_info.dart';
import 'package:soul_image/features/home/data/datasources/local_datacourse.dart';
import 'package:soul_image/features/home/data/datasources/remote_datasource.dart';
import 'package:soul_image/features/home/data/models/image_model.dart';
import 'package:soul_image/features/home/domain/entities/image.dart';
import 'package:soul_image/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl({
    required this.networkInfo,
    required this.homeRemoteDatasource,
    required this.homeLocalDataSource,
  });

  final HomeRemoteDataSource homeRemoteDatasource;
  final HomeLocalDataSource homeLocalDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<List<ImageEntity>> getCuratedImages(int page) async {
    return _getEntities(() => homeRemoteDatasource.getCuratedImages(page));
  }

  Future<List<ImageEntity>> _getEntities(
      Future<List<ImageModel>> Function() getFunction) async {
    if (await networkInfo.isConnected) {
      try {
        final models = await getFunction();

        // Cache fetched image models into local storage
        homeLocalDataSource.cacheImages(models);

        return _getEntitiesFrom(models);
      } on ServerException {
        throw ServerException();
      }
    } else {
      try {
        final cachedImages = await homeLocalDataSource.getImagesFromCache();
        return _getEntitiesFrom(cachedImages);
      } on CacheException {
        throw CacheException();
      }
    }
  }

  List<ImageEntity> _getEntitiesFrom(List<ImageModel> models) {
    return models.map<ImageEntity>((model) => model.toEntity()).toList();
  }
}
