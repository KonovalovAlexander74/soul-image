import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:soul_image/features/home/domain/entities/image_url.dart';
import 'package:soul_image/features/home/presentation/state_manager/bottom_nav_bar_provider.dart';
import 'package:soul_image/features/home/presentation/state_manager/search_page_provider.dart';
import 'package:soul_image/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:soul_image/features/home/presentation/widgets/search_image_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        actions: [
          IconButton(
            iconSize: 25,
            onPressed: () {
              context.read<SearchProvider>().toggleSearchBar();
            },
            icon: const Icon(Icons.search),
          ),
        ],
        title: 'SOUL IMAGE',
        height: 40,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: const [
            SearchBar(),
            Expanded(
              child: _SearchImagesGrid(),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerModel = context.watch<SearchProvider>();

    controller.text = providerModel.query;
    controller.selection = TextSelection.fromPosition(
      TextPosition(offset: controller.text.length),
    );

    if (providerModel.isSearchBarVisible) {
      return Column(
        children: [
          TextFormField(
            controller: controller,
            onFieldSubmitted: (value) {
              if (value.isNotEmpty && value != providerModel.query) {
                providerModel.query = value;
                providerModel.getSearchedImages();
              }
              providerModel.closeSearchBar();
            },
            textAlignVertical: TextAlignVertical.bottom,
            autofocus: true,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              isDense: false,
              isCollapsed: false,
              suffixIcon: IconButton(
                onPressed: () {
                  controller.text = '';
                },
                icon: const Icon(
                  Icons.clear,
                  color: Colors.black,
                ),
                iconSize: 25,
              ),
              focusColor: Colors.black,
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      );
    } else {
      return Container();
    }
  }
}

// TODO: Move to new file
class _SearchImagesGrid extends StatefulWidget {
  const _SearchImagesGrid({Key? key}) : super(key: key);

  @override
  State<_SearchImagesGrid> createState() => __SearchImagesGridState();
}

class __SearchImagesGridState extends State<_SearchImagesGrid> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<SearchProvider>().getSearchedImages(isInitState: true);

    controller.addListener(_listenScroll);
  }

  @override
  void dispose() {
    controller.removeListener(_listenScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();

    if (searchProvider.doScrollToTop && controller.hasClients) {
      controller.jumpTo(0);
      searchProvider.doScrollToTop = false;
    }

    if (searchProvider.images.isEmpty) {
      return Center(
        child: searchProvider.isNoResults
            ? const Center(
                child: Text('No results'),
              )
            : const CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 1.0,
              ),
      );
    } else {
      return ListView.separated(
        controller: controller,
        itemCount: searchProvider.images.length,
        itemBuilder: (context, index) {
          searchProvider.checkForPagination(index);

          return SearchImageCard(
            image: searchProvider.images[index],
            size: ImageSize.medium,
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 40),
      );
    }
  }

  void _listenScroll() {
    final bottomNavBarProvider = context.read<BottomNavBarProvider>();

    if (controller.position.userScrollDirection == ScrollDirection.reverse) {
      bottomNavBarProvider.hide();
    }
    if (controller.position.userScrollDirection == ScrollDirection.forward) {
      bottomNavBarProvider.show();
    }
  }
}
