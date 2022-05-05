import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/extensions/string_extensions.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/screens/home/home_viewmodel.dart';

import '../../../constants/constanst.dart';

class NowPlaying extends ConsumerWidget {
  const NowPlaying({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeViewModel = ref.watch(homeViewModelProvider);
    return homeViewModel.nowPlayings.when(
      data: (value) {
        return CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: AppSize.size_2,
            enlargeCenterPage: true,
          ),
          items: _getListImages(value),
        );
      },
      error: (error, stack) =>
          const Center(child: Text(AppString.errorMessage)),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

List<Widget> _getListImages(List<Movie> movies) {
  return movies
      .map<Widget>(
        (item) => Container(
          margin: const EdgeInsets.all(AppSize.size_4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.size_4),
            child: CachedNetworkImage(
              imageUrl: item.posterPath.toImageUrl(),
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
      )
      .toList();
}
