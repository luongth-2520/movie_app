import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/extensions/string_extensions.dart';
import 'package:movie_app/models/movie.dart';

import '../../../constants/constanst.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: AppSize.size_108,
        margin: const EdgeInsets.all(AppSize.size_6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 108 / 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSize.size_10),
                child: CachedNetworkImage(
                  imageUrl: movie.posterPath.toImageUrl(),
                ),
              ),
            ),
            Expanded(
              child: Text(
                movie.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: AppSize.size_16),
              ),
            ),
            Text(
              "(${movie.releaseDate?.substring(0, 4)})",
              style: const TextStyle(
                fontSize: AppSize.size_16,
                color: AppColor.hurricane,
              ),
            ),
          ],
        ),
      ),
      onTap: () {},
    );
  }
}
