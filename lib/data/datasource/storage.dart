import 'package:shared_preferences/shared_preferences.dart';

class Storage {

  static const TOKEN = "TOKEN";
  static late SharedPreferences prefs;
  

  static configurePrefs() async {

    
    prefs = await SharedPreferences.getInstance();
   
    
  }
}