import 'package:soul_image/core/usecases/usecases.dart';
import 'package:soul_image/features/home/domain/entities/image.dart';
import 'package:soul_image/features/home/domain/repositories/home_repository.dart';

class GetSearchedImages extends UseCase<List<ImageEntity>, SearchImagesParams> {
  GetSearchedImages(this.homeRepository);

  final HomeRepository homeRepository;

  @override
  Future<List<ImageEntity>> call(SearchImagesParams params) async {
    return await homeRepository.getSearchedImages(
      page: params.page,
      query: params.query,
      color: params.color,
    );
  }
}

class SearchImagesParams {
  final int page;
  final String query;
  final String? color;

  SearchImagesParams({required this.page, required this.query, this.color});
}
