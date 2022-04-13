import 'package:flutter/material.dart';
import 'package:flutter_movie_app/widgets/movie_display.dart';

import '../models/Movie.dart';

class MovieList extends StatelessWidget {
  final List movies;
  final ScrollController controller;

  const MovieList({Key?key, required this.movies, required this.controller}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      controller: controller,
      itemBuilder: (context, index) {
        var movie=Movie(movies[index]);
        return MovieDisplay(movie);
      },
    );
  }
}

