import 'package:flutter/material.dart';
import 'package:flutter_movie_app/routes/route_generator.dart';


class App extends StatelessWidget {
  const App({Key?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter Movie App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        colorScheme: const ColorScheme.dark(),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: generateRoutes(context)
    );
  }
}
