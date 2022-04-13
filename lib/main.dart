import 'package:flutter/material.dart';
import 'package:flutter_movie_app/API/MovieAPI.dart';
import 'package:flutter_movie_app/API/user_preferences%20.dart';


import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences.init();
  await MovieApi.init();
  runApp(const App());
}