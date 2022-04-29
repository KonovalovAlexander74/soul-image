import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soul_image/features/home/presentation/state_manager/home_page_provider.dart';
import 'package:soul_image/features/home/presentation/widgets/image_card.dart';

class HomePageGridView extends StatefulWidget {
  const HomePageGridView({Key? key}) : super(key: key);

  @override
  State<HomePageGridView> createState() => _HomePageGridViewState();
}

class _HomePageGridViewState extends State<HomePageGridView> {
  final gridDelagate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      childAspectRatio: 3 / 4);

  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<HomeProvider>().getCuratedImages(isInitState: true);
  }

  // final assetUrl =
  //     'https://images.pexels.com/photos/11776784/pexels-photo-11776784.jpeg?auto=compress&cs=tinysrgb&dpr=1&fit=crop&h=200&w=280';

  @override
  Widget build(BuildContext context) {
    final providerModel = context.watch<HomeProvider>();

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: providerModel.images.isEmpty
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeWidth: 1.0,
              ),
            )
          : GridView.builder(
              // controller: scrollController,
              itemCount: providerModel.images.length,
              gridDelegate: gridDelagate,
              itemBuilder: (context, index) {
                providerModel.checkForPagination(index);

                return ImageCard(
                  image: providerModel.images[index],
                );
              },
            ),
    );
  }
}
