import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/constants/images.dart';
import 'package:movie_app/constants/sizes.dart';
import 'package:movie_app/extensions/string_extensions.dart';
import 'package:movie_app/models/movie.dart';

class MovieCardItem extends StatelessWidget {
  const MovieCardItem({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppSize.size_8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.size_10)),
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 380 / 160,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.size_10),
              child: CachedNetworkImage(
                imageUrl: movie.posterPath.toImageUrl(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 380 / 160,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppSize.size_10)),
            ),
          ),
          Positioned(
            top: AppSize.size_16,
            left: AppSize.size_16,
            child: Text(
              "MOVIE(${movie.releaseDate?.substring(0, 4)})",
              style: const TextStyle(
                  fontSize: AppSize.size_16, color: Colors.white),
            ),
          ),
          Positioned(
            bottom: AppSize.size_16,
            left: AppSize.size_16,
            child: Text(
              movie.title,
              style: const TextStyle(
                  fontSize: AppSize.size_19,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
              top: AppSize.size_16,
              right: AppSize.size_16,
              child: Row(
                children: [
                  SvgPicture.asset(AppImages.iconStar),
                  Text(
                    "${movie.voteAverage}",
                    style: const TextStyle(
                        color: Colors.white, fontSize: AppSize.size_19),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
