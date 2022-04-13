//flutter imports:
import 'package:flutter/material.dart';
//Api imports:
import 'package:flutter_movie_app/API/MovieAPI.dart';
// widget imports:
import '../screens/splash.dart';
import 'movie_list.dart';

class SearchResults extends StatefulWidget {
  final String selectedTerm;
  final bool isSearching;
  final bool loaded;
  final List movies;
  final bool isEmpty;
  const SearchResults({Key ?key, required this.selectedTerm, required this.isSearching, required this.loaded, required this.movies, required this.isEmpty}) : super(key: key);

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  late var movies = widget.movies;
  var page =1; //page number, for infinite scrolling
  late ScrollController controller; //Scroll controller for infinite scrolling



  @override
  void initState()  {
    super.initState();
    controller = ScrollController()..addListener(handleScrolling);
  }

  Future<void> handleScrolling() async {
    if (controller.offset >= controller.position.maxScrollExtent) {
      setState(() {
        ++page;
      });
       var movieList= await MovieApi.getNextPageSearch(page, widget.selectedTerm);

        setState(() {
          movies.addAll(movieList['results']);
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
    if(widget.loaded) {
      movies=widget.movies;
    }
    if(widget.isEmpty) {
      return const Center(
        child: Text("No results found"),
      );
    }
    return widget.isSearching ?
    (widget.loaded ?
    Container(child: MovieList(movies: movies, controller: controller,), margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07)) :
    const Splash())
        : Container() ;
  }
}
