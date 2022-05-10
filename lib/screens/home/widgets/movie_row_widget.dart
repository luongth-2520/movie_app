import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/movie_type.dart';
import 'package:movie_app/screens/home/home_viewmodel.dart';
import 'package:movie_app/screens/home/widgets/movie_list_widget.dart';

import '../../../constants/constanst.dart';

class MovieRow extends ConsumerWidget {
  const MovieRow({Key? key, required this.movieType}) : super(key: key);

  final MovieType movieType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue moviesData;
    switch (movieType) {
      case MovieType.nowPlaying:
        moviesData = ref.watch(homeViewModelProvider).nowPlayings;
        break;
      case MovieType.upComing:
        moviesData = ref.watch(homeViewModelProvider).upcomings;
        break;
      case MovieType.popular:
        moviesData = ref.watch(homeViewModelProvider).populars;
        break;
      case MovieType.topRated:
        moviesData = ref.watch(homeViewModelProvider).topRateds;
        break;
    }
    return moviesData.when(
        data: (value) => MovieList(movies: value),
        error: (error, stack) =>
            const Center(child: Text(AppString.errorMessage)),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}
