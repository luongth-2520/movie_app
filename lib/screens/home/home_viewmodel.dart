import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/repository/movie_repository.dart';

final homeViewModelProvider = ChangeNotifierProvider(
  (ref) => HomeViewModel(movieRepository: MovieRepository()),
);

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required this.movieRepository}) {
    getNowPlayingMovies();
  }

  final MovieRepository movieRepository;
  AsyncValue<List<Movie>> nowPlayings = const AsyncValue.loading();

  Future getNowPlayingMovies() async {
    try {
      final movies = await movieRepository.getPlayNowMovies();
      nowPlayings = AsyncValue.data(movies.results);
    } catch (e) {
      nowPlayings = AsyncValue.error(e);
    }
    notifyListeners();
  }
}
