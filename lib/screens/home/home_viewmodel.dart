import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/movie_type.dart';
import 'package:movie_app/repository/movie_repository.dart';

final homeViewModelProvider = ChangeNotifierProvider(
  (ref) => HomeViewModel(movieRepository: MovieRepository()),
);

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required this.movieRepository}) {
    getMovies(MovieType.nowPlaying);
    getMovies(MovieType.upComing);
    getMovies(MovieType.popular);
    getMovies(MovieType.topRated);
  }

  final MovieRepository movieRepository;
  AsyncValue<List<Movie>> nowPlayings = const AsyncValue.loading();
  AsyncValue<List<Movie>> upcomings = const AsyncValue.loading();
  AsyncValue<List<Movie>> populars = const AsyncValue.loading();
  AsyncValue<List<Movie>> topRateds = const AsyncValue.loading();

  Future getMovies(MovieType type) async {
    try {
      switch (type) {
        case MovieType.nowPlaying:
          final movies = await movieRepository.getPlayNowMovies();
          nowPlayings = AsyncValue.data(movies.results);
          break;
        case MovieType.upComing:
          final movies = await movieRepository.getUpcomingMovies();
          upcomings = AsyncValue.data(movies.results);
          break;
        case MovieType.popular:
          final movies = await movieRepository.getPopularMovies();
          populars = AsyncValue.data(movies.results);
          break;
        case MovieType.topRated:
          final movies = await movieRepository.getTopRatedMovies();
          topRateds = AsyncValue.data(movies.results);
          break;
      }
    } catch (e) {
      switch (type) {
        case MovieType.nowPlaying:
          nowPlayings = AsyncValue.error(e);
          break;
        case MovieType.upComing:
          upcomings = AsyncValue.error(e);
          break;
        case MovieType.popular:
          populars = AsyncValue.error(e);
          break;
        case MovieType.topRated:
          topRateds = AsyncValue.error(e);
          break;
      }
    }
    notifyListeners();
  }
}
