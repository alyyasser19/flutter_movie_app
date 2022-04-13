import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';
import '../screens/search.dart';
import '../screens/tabs.dart';

generateRoutes(context) {
  return {
    Home.routeName  : (context) => Home(),
    Tabs.routeName  : (context) => Tabs(),
    Search.routeName: (context) => Search(),
  };
}