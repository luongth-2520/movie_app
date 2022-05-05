import 'package:dio/dio.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:movie_app/constants/constanst.dart';
import 'package:movie_app/models/movies.dart';

class MovieApi {
  late Dio _dio;
  static MovieApi? _instance;
  final _apiKey = FlutterConfig.get("API_KEY");
  final _baseUrl = FlutterConfig.get("BASE_URL");

  factory MovieApi() {
    _instance ??= MovieApi._internal();
    return _instance ?? MovieApi._internal();
  }

  MovieApi._internal() {
    _dio = Dio();
    _dio.options = BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 10000,
      sendTimeout: 10000,
      baseUrl: _baseUrl,
      queryParameters: {"api_key": _apiKey},
    );
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

  Future<Movies> getNowPlaying() async {
    final response = await _dio.get(AppString.nowPlaying);
    return Movies.fromJson(response.data);
  }
}
