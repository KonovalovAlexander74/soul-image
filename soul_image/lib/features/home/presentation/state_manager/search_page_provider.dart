import 'package:flutter/material.dart';
import 'package:soul_image/features/home/domain/entities/image.dart';
import 'package:soul_image/features/home/domain/usecases/get_serched_images.dart';

class SearchProvider extends ChangeNotifier {
  SearchProvider(this._getSearchedImages);

  final GetSearchedImages _getSearchedImages;

  final List<ImageEntity> images = [];

  int _currentPage = 1;
  bool _isLoadingInProgress = false;
  bool _isNoResults = false;

  String query = 'image';
  String color = '';

  bool _isSearchBarVisible = true;

  bool doScrollToTop = false;

  Future<void> getNewPageImages() async {
    /// Prevents refetching images, while switching between bottom vatigation bar tabs
    if (_isLoadingInProgress) return;

    _isLoadingInProgress = true;

    try {
      var color = this.color.isEmpty ? null : this.color;

      var newImages = await _getSearchedImages.call(
        SearchImagesParams(page: _currentPage, query: query, color: color),
      );

      images.addAll(newImages);

      notifyListeners();

      _isLoadingInProgress = false;
      _currentPage += 1;
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }

  Future<void> getSearchedImages({
    bool isInitState = false,
  }) async {
    /// Prevents refetching images, while switching between bottom vatigation bar tabs
    if (isInitState && images.isNotEmpty) return;
    if (_isLoadingInProgress) return;

    _currentPage = 1;

    _isLoadingInProgress = true;

    try {
      var color = this.color.isEmpty ? null : this.color;

      var newImages = await _getSearchedImages.call(
        SearchImagesParams(page: _currentPage, query: query, color: color),
      );

      images.clear();
      images.addAll(newImages);

      if (images.isEmpty) {
        _isNoResults = true;
      } else {
        _isNoResults = false;

        if (!isInitState) {
          doScrollToTop = true;
        }
      }

      notifyListeners();

      _currentPage += 1;
      _isLoadingInProgress = false;
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }

  void checkForPagination(int index) {
    if (index > images.length - 3) {
      getNewPageImages();
    }
  }

  void showSearchBar() {
    _isSearchBarVisible = true;
    notifyListeners();
  }

  void closeSearchBar() {
    _isSearchBarVisible = false;
    notifyListeners();
  }

  void toggleSearchBar() {
    _isSearchBarVisible = !_isSearchBarVisible;
    notifyListeners();
  }

  bool get isSearchBarVisible => _isSearchBarVisible;
  bool get isNoResults => _isNoResults;
}
