// screen imports
import '../screens/home.dart';
import '../screens/search.dart';
import '../screens/tabs.dart';

generateRoutes(context) {
  return {
    Home.routeName  : (context) => const Home(),
    Tabs.routeName  : (context) => const Tabs(),
    Search.routeName: (context) => const Search(),
  };
}