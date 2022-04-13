//flutter imports:
import 'package:flutter/material.dart';
//API imports:
import 'package:flutter_movie_app/API/MovieAPI.dart';
//Widget imports:
import 'package:flutter_movie_app/screens/splash.dart';
import 'package:flutter_movie_app/widgets/movie_list.dart';


class Home extends StatefulWidget {
  static const routeName = '/movies';

  const Home({Key?key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late var movies =[];
  bool loaded = false; // for loading indicator
  var page = 0;

  late ScrollController controller;

  void loadTMDB() async{


    var movieList = await MovieApi.getTrendingMovies();

    setState(() {
      loaded = true;
      page= 1;
      movies = movieList["results"];
    });
  }

  @override
  void initState()  {
    super.initState();
    controller = ScrollController()..addListener(handleScrolling);
    loadTMDB();
  }

  Future<void> handleScrolling() async {
    if (controller.offset >= controller.position.maxScrollExtent) {
      setState(() {
        ++page;
      });
      var next=await MovieApi.getNextPage(page);

        setState(() {
          movies.addAll(next["results"]);
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
    return Scaffold(
      appBar : AppBar(
        title :const Text('Trending Movies',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18)),
        leading: const Icon(Icons.movie, color: Colors.white),
      ),
      body:  Center(
        child: loaded ? MovieList(movies: movies, controller: controller) : const Splash() ,
      ),
      );
  }

}
