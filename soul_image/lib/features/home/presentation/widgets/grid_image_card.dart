import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:soul_image/core/config/themes/app_theme.dart';
import 'package:soul_image/features/home/domain/entities/image.dart';
import 'package:soul_image/features/home/domain/entities/image_url.dart';
import 'package:soul_image/features/home/presentation/screens/image_details.dart';

class GridImageCard extends StatelessWidget {
  const GridImageCard({Key? key, required this.image, required this.size})
      : super(key: key);

  final ImageEntity image;
  final ImageSize size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Hero(
              tag: image.url.original,
              child: _ImageBox(
                imageUrl: image.url.fromImageSize(size),
              ),
            ),
            _ImageLabel(
              photographer: image.photographer,
              description: image.description,
            ),
          ],
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            highlightColor: Colors.white12,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageDetailsWidget(image: image),
                ),
              );
            },
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
          return const Center(
            child: Text('No data'),
          );
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
    return ColoredBox(
      color: AppColors.specialWhiteColor,
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
