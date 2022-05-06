import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:soul_image/features/home/domain/entities/image_url.dart';
import 'package:soul_image/features/home/presentation/state_manager/bottom_nav_bar_provider.dart';
import 'package:soul_image/features/home/presentation/state_manager/home_page_provider.dart';
import 'package:soul_image/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:soul_image/features/home/presentation/widgets/grid_image_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();

  final gridDelagate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 6,
    crossAxisSpacing: 6,
    childAspectRatio: 3 / 4,
  );

  @override
  void initState() {
    super.initState();

    context.read<HomeProvider>().getCuratedImages(isInitState: true);

    final bottomNavBarProvider = context.read<BottomNavBarProvider>();

    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        bottomNavBarProvider.hide();
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        bottomNavBarProvider.show();
      }
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(() {});
    super.dispose();
  }

  // final assetUrl =
  //     'https://images.pexels.com/photos/11776784/pexels-photo-11776784.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280';

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'SOUL IMAGE',
        height: 40,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: homeProvider.images.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  strokeWidth: 1.0,
                ),
              )
            : GridView.builder(
                controller: scrollController,
                itemCount: homeProvider.images.length,
                gridDelegate: gridDelagate,
                itemBuilder: (context, index) {
                  homeProvider.checkForPagination(index);

                  return GridImageCard(
                    image: homeProvider.images[index],
                    size: ImageSize.tiny,
                  );
                },
              ),
      ),
    );
  }
}
