import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tmdb_api/tmdb_api.dart';

import '../screens/splash.dart';
import 'movie_list.dart';

class SearchResults extends StatefulWidget {
  final String selectedTerm;
  final bool isSearching;
  final bool loaded;
  final List movies;
  final tmdb;
  const SearchResults({Key ?key, required this.selectedTerm, required this.isSearching, required this.loaded, required this.movies, required this.tmdb}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late var movies = widget.movies;
  var page =1;
  late ScrollController controller;


  void initState()  {
    super.initState();
    controller = ScrollController()..addListener(handleScrolling);
  }

  Future<void> handleScrolling() async {
    if (controller.offset >= controller.position.maxScrollExtent) {
      setState(() {
        ++page;
      });
      await widget.tmdb.v3.trending.getTrending(
        mediaType: MediaType.movie,
        page: page,
      ).then((value) {
        setState(() {
          movies.addAll(value["results"]);
        });
      });
    }
  }

  @override
  void dispose() {
    controller.removeListener(handleScrolling);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isSearching || widget.loaded ? (widget.loaded ? Container(child: MovieList(movies: movies, controller: controller,), margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1)) : const Splash()) : Container() ;
  }
}
