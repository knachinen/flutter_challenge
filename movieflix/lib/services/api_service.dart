import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movieflix/models/movie_detail_model.dart';
import 'package:movieflix/models/movie_model.dart';

class ApiService {
  static const String movieBaseUrl =
      'https://movies-api.nomadcoders.workers.dev';
  static const String popular = 'popular';
  static const String now = 'now-playing';
  static const String comingSoon = 'coming-soon';

  static Future<List<MovieModel>> getPopularMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$movieBaseUrl/$popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> movies = jsonDecode(response.body);
      for (var movie in movies['results']) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getNowMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$movieBaseUrl/$now');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> movies = jsonDecode(response.body);
      for (var movie in movies['results']) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getComingSoonMovies() async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$movieBaseUrl/$comingSoon');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> movies = jsonDecode(response.body);
      for (var movie in movies['results']) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieById(num id) async {
    final url = Uri.parse("$movieBaseUrl/movie?id=$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      return MovieDetailModel.fromJson(movie);
    }
    throw Error();
  }
}
