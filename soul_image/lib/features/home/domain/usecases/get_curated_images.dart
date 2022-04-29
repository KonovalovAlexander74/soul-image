import 'package:soul_image/core/usecases/usecases.dart';
import 'package:soul_image/features/home/domain/entities/image.dart';
import 'package:soul_image/features/home/domain/repositories/home_repository.dart';

class GetCuratedImagesUseCase
    extends UseCase<List<ImageEntity>, CuratedImagesParams> {
  final HomeRepository _homeRepository;

  GetCuratedImagesUseCase(this._homeRepository);

  @override
  Future<List<ImageEntity>> call(CuratedImagesParams params) async {
    return await _homeRepository.getCuratedImages(params.page);
  }
}

class CuratedImagesParams {
  final int page;

  CuratedImagesParams({required this.page});
}
