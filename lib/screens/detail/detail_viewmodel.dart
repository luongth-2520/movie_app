import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/models/cast.dart';
import 'package:movie_app/repository/movie_repository.dart';

final detailViewModelProvider = ChangeNotifierProvider(
    (ref) => DetailViewModel(movieRepository: MovieRepository()));

class DetailViewModel extends ChangeNotifier {
  DetailViewModel({required this.movieRepository});
  final MovieRepository movieRepository;

  AsyncValue<List<Cast>> casts = const AsyncValue.loading();

  Future getCasts(int movieId) async {
    try {
      final data = await movieRepository.getCasts(movieId);
      casts = AsyncValue.data(data.cast ?? []);
    } catch (e) {
      casts = AsyncValue.error(e);
    }
    notifyListeners();
  }
}
