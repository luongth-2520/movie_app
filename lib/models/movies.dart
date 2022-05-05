import 'package:freezed_annotation/freezed_annotation.dart';

import 'movie.dart';

part 'movies.freezed.dart';
part 'movies.g.dart';

@freezed
class Movies with _$Movies {
  factory Movies({
    required int page,
    @Default([]) List<Movie> results,
  }) = _Movies;

  factory Movies.fromJson(Map<String, dynamic> json) => _$MoviesFromJson(json);
}
