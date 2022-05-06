import 'package:flutter/material.dart';
import 'package:soul_image/features/home/domain/entities/image.dart';
import 'package:soul_image/features/home/domain/usecases/get_curated_images.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider(this._getCuratedImages);

  final GetCuratedImagesUseCase _getCuratedImages;

  final List<ImageEntity> images = [];

  int _currentPage = 1;
  bool _isLoadingInProgress = false;

  Future<void> getCuratedImages({bool isInitState = false}) async {
    /// Prevents refetching images, while switching between bottom vatigation bar tabs
    if (isInitState && images.isNotEmpty) return;
    if (_isLoadingInProgress) return;

    _isLoadingInProgress = true;

    try {
      var newImages = await _getCuratedImages.call(
        CuratedImagesParams(page: _currentPage),
      );
      images.addAll(newImages);
      notifyListeners();

      _isLoadingInProgress = false;
      _currentPage += 1;
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }

  void checkForPagination(int index) {
    if (index > images.length - 2) {
      getCuratedImages();
    }
  }
}
