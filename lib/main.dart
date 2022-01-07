import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_consware/data/shared_preference.dart';
import 'package:flutter_consware/domain/userCase/db_case_controller.dart';
import 'package:flutter_consware/presentation/routes/routes.dart';
import 'package:flutter_consware/presentation/singIn/sign_in_presentation.dart';
import 'package:provider/provider.dart';

import 'data/auth_firebase_impl.dart';
import 'data/crud_firebase_impl.dart';
import 'domain/userCase/auth_case_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs =  UserPreference();
  await prefs.initPrefs();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  final UserPreference prefs =  UserPreference();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context,snapshot){
        if (snapshot.hasError) {
          return  Container();
        } else if (snapshot.connectionState == ConnectionState.done) {
          return  MultiProvider(
            providers: [
              
              ChangeNotifierProvider(create: (_) =>  AuthCaseController(authRespositoryInterface:  AuthFirebaseImpl(),dbRepositoryInterface:  CrudFirebaseImpl())),
              ChangeNotifierProvider(create: (_) =>  DataBaseController(dbRepositoryInterface:  CrudFirebaseImpl())),
            ],
            child:   MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Material App',
              initialRoute: /* ( prefs.loginToken != "" ) 
                          ?  HomePage.routeName*/
                           SignInScreen.routeName,
              routes: appRoutes,
            ),
            
            
          );
        } else {
          return const Center(
          child:  CircularProgressIndicator(),
        ); 
        }
      }
    );
    
  }
}