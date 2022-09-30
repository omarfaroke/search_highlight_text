import 'dart:convert';

import 'package:example/search/models/movie.dart';
import 'package:flutter/services.dart';

class MoviesRepoController {
  Future<List<MovieModel>> searchMovies(String? query) async {
    // get movies from assets json file
    final movies = await _getMoviesFromAssets();
    // filter movies by query

    if (query == null || query.isEmpty) {
      return movies;
    }

    final filteredMovies = movies.where((movie) {
      final titleLower = movie.title.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();
    return filteredMovies;
  }

  Future<List<MovieModel>> getMovies() async {
    // get movies from assets json file
    final movies = await _getMoviesFromAssets();
    return movies;
  }

  Future<List<MovieModel>> _getMoviesFromAssets() async {
    final moviesJson = await rootBundle.loadString('assets/movies.json');
    final movies = json.decode(moviesJson) as List;
    final moviesList =
        movies.map((movie) => MovieModel.fromMap(movie)).toList();
    return moviesList;
  }
}
