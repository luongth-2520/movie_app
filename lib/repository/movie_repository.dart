import 'package:movie_app/models/movies.dart';
import 'package:movie_app/network/movie_api.dart';

class MovieRepository {
  final MovieApi movieApi = MovieApi();

  static final MovieRepository _instance = MovieRepository._internal();

  factory MovieRepository() {
    return _instance;
  }

  MovieRepository._internal();

  Future<Movies> getPlayNowMovies() => movieApi.getNowPlaying();

  Future<Movies> getUpcomingMovies() => movieApi.getUpcoming();

  Future<Movies> getPopularMovies() => movieApi.getPopular();

  Future<Movies> getTopRatedMovies() => movieApi.getTopRated();

  Future<Movies> searchMovies(String query) => movieApi.search(query);
}
