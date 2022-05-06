import 'package:flutter/material.dart';
import 'package:soul_image/core/extensions/extensions.dart';
import 'package:soul_image/features/home/domain/entities/image.dart';
import 'package:soul_image/features/home/presentation/widgets/custom_app_bar.dart';

class ImageDetailsWidget extends StatelessWidget {
  const ImageDetailsWidget({Key? key, required this.image}) : super(key: key);

  final ImageEntity image;

  @override
  Widget build(BuildContext context) {
    final _averageColor = HexColor.fromHex(image.avgColor);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'SOUL IMAGE',
        color: HexColor.fromHex(image.avgColor).withOpacity(0.2),
      ),
      body: ColoredBox(
        color: _averageColor.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Hero(
                tag: image.url.original,
                child: Image.network(
                  image.url.portrait,
                  fit: BoxFit.contain,
                  height: 600,
                  frameBuilder:
                      (context, child, frame, wasSynchronouslyLoaded) {
                    if (frame == null) {
                      return Container(
                        color: _averageColor.withOpacity(0.5),
                        height: 600,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: _averageColor,
                            strokeWidth: 1.0,
                          ),
                        ),
                      );
                    }

                    return child;
                  },
                ),
              ),
              _PhotographerTitle(photographer: image.photographer),
              const SizedBox(
                height: 10,
              ),
              _Description(description: image.description)
            ],
          ),
        ),
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
    required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        description,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          letterSpacing: 2,
          wordSpacing: 3,
        ),
      ),
    );
  }
}

class _PhotographerTitle extends StatelessWidget {
  const _PhotographerTitle({
    Key? key,
    required this.photographer,
  }) : super(key: key);

  final String photographer;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        photographer,
        style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 25,
          letterSpacing: 4,
          wordSpacing: 6,
        ),
      ),
    );
  }
}
