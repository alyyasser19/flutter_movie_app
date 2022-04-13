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
        if(movies[index]['poster_path'] == null || movies[index]['title'] == null || movies[index]['overview'] == null || movies[index]['release_date'] == null ) {
          return Container();
        }
        var movie=Movie(movies[index]);
        return MovieDisplay(movie);
      },
    );
  }
}

