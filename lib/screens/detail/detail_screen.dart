import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/constants/images.dart';
import 'package:movie_app/constants/sizes.dart';
import 'package:movie_app/extensions/string_extensions.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/detail/detail_viewmodel.dart';
import 'package:movie_app/screens/detail/widgets/casts_list_widget.dart';

class DetailScreen extends ConsumerWidget {
  static const routeName = "DetailScreen";
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movie = ModalRoute.of(context)?.settings.arguments as Movie;
    ref.read(detailViewModelProvider).getCasts(movie.id);
    return LayoutBuilder(
      builder: (_, viewConstraints) => Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 414 / 200,
                      child: CachedNetworkImage(
                        width: double.infinity,
                        imageUrl: movie.posterPath.toImageUrl(),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: AppSize.size_32,
                      left: AppSize.size_32,
                      child: GestureDetector(
                          onTap: () => Navigator.pop(context), child: SvgPicture.asset(AppImages.iconBack)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        movie.title,
                        style: const TextStyle(fontSize: AppSize.size_25, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.bookmark_add_outlined),
                  ],
                ),
                Row(
                  children: [
                    Text("${movie.releaseDate} | ${movie.voteAverage}/10"),
                    const Icon(
                      Icons.star,
                      color: Colors.red,
                    )
                  ],
                ),
                Text(movie.overview ?? ""),
                const Text(
                  "Casts & Crew",
                  style: TextStyle(fontSize: AppSize.size_20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: double.infinity, child: AspectRatio(aspectRatio: 414 / 100, child: CastsList()))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
