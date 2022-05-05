import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/repository/movie_repository.dart';

final searchViewModelProvider = ChangeNotifierProvider(
  (ref) => SearchViewModel(movieRepository: MovieRepository()),
);

class SearchViewModel extends ChangeNotifier {
  SearchViewModel({required this.movieRepository});
  final MovieRepository movieRepository;

  AsyncValue<List<Movie>> searchData = const AsyncValue.data([]);

  Future searchMovies(String query) async {
    searchData = const AsyncValue.loading();
    notifyListeners();
    try {
      final data = await movieRepository.searchMovies(query);
      searchData = AsyncValue.data(data.results);
    } catch (e) {
      searchData = AsyncValue.error(e);
    }
    notifyListeners();
  }
}
