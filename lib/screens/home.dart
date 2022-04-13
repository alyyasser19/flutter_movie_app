
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movie_app/screens/splash.dart';
import 'package:flutter_movie_app/widgets/movie_list.dart';
import 'package:tmdb_api/tmdb_api.dart';



class Home extends StatefulWidget {
  static const routeName = '/movies';

  const Home({Key?key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final TMDB _tmdb;
  late var movies =[];
  bool loaded = false;
  var page = 0;

  late ScrollController controller;

  void loadTMDB() async{
    await dotenv.load();
    var apiKeyV3 = dotenv.env['API_KEY_V3'] ?? '';
    var apiKeyV4 = dotenv.env['API_READ_V4'] ?? '';
    final tmdbWithCustomLogs = TMDB(
      ApiKeys(apiKeyV3, apiKeyV4),
    );

    var movieList = await tmdbWithCustomLogs.v3.trending.getTrending(
      mediaType: MediaType.movie,
    );

    setState(() {
      _tmdb = tmdbWithCustomLogs;
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
      await _tmdb.v3.trending.getTrending(
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
