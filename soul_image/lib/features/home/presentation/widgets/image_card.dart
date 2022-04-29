import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:soul_image/core/config/themes/app_theme.dart';
import 'package:soul_image/features/home/domain/entities/image.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({Key? key, required this.image}) : super(key: key);

  final ImageEntity image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ImageBox(
          imageUrl: image.url.tiny,
        ),
        Expanded(
          child: _ImageLabel(
            photographer: image.photographer,
            description: image.description,
          ),
        ),
      ],
    );
  }
}

class _ImageBox extends StatelessWidget {
  const _ImageBox({Key? key, required this.imageUrl}) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: 200,

      // child: Center(child: Text(imageUrl)),

      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) {
          return Image(
            image: imageProvider,
            fit: BoxFit.cover,
          );
        },
        placeholder: (context, url) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
              strokeWidth: 1.0,
            ),
          );
        },
        errorWidget: (context, url, error) {
          return const Placeholder();
        },
      ),
    );
  }
}

class _ImageLabel extends StatelessWidget {
  const _ImageLabel(
      {Key? key, required this.photographer, required this.description})
      : super(key: key);

  final String photographer;
  final String description;

  @override
  Widget build(BuildContext context) {
    const borderSide = BorderSide(width: 0.5);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.specialWhiteColor,
        border: Border(
          bottom: borderSide,
          left: borderSide,
          right: borderSide,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                photographer,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                description,
                style: Theme.of(context).textTheme.caption,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
