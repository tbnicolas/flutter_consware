import 'package:shared_preferences/shared_preferences.dart';

class UserPreference{

  static final UserPreference _instancia = UserPreference._internal();
  factory UserPreference(){
    return _instancia;
  }
  UserPreference._internal();
  SharedPreferences? _prefs;

   Future<SharedPreferences> initPrefs() async{
     _prefs = await SharedPreferences.getInstance();
     return _prefs!;
  }

  //GET y SET del Login Token

  String get loginToken{
    return _prefs?.getString('loginToken') ?? "";
  }

  set loginToken(String value){
    _prefs?.setString('loginToken', value);
  }




}