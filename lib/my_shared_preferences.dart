import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPrefernces {

  static SharedPreferences? _preferences;

  static Future init () async{
    _preferences = await SharedPreferences.getInstance();
  }


  static Future setPrevNumbers (List<String> prevNumbers) async {
    await _preferences!.setStringList('prevRandomNumbers', prevNumbers);
  }

  static List? getPrevNumbers () {
    _preferences!.getStringList('prevRandomNumbers');
  }






}
