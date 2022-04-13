//flutter imports
import 'package:flutter/material.dart';
//plugin imports
import 'package:lottie/lottie.dart';

class Splash extends StatelessWidget {
  const Splash({Key?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
        child: Center(
          child: Lottie.asset('assets/lottie/movie.json',
          ),
        ),
      ),
    );
  }
}
