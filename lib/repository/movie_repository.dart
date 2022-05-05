import 'package:movie_app/models/movies.dart';
import 'package:movie_app/network/movie_api.dart';

class MovieRepository {
  final MovieApi movieApi = MovieApi();

  Future<Movies> getPlayNowMovies() => movieApi.getNowPlaying();
}
