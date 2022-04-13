import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _prefs;

  static Future init()async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future setSearchResults(List searchResults) async {
    var string = searchResults.toString().replaceAll("[", "").replaceAll("]", "");
    await _prefs.setString('searchResults', string);
  }

  static Future<List<String>> getSearchResults() async {
    String string = _prefs.getString('searchResults') ?? '';
    List<String> list = string.split(',') ;
    for(int i = 0; i < list.length; i++){
      list[i] = list[i].trim();
    }
    return list;
  }

}