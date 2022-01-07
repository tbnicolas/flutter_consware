

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_consware/data/shared_preference.dart';
import 'package:flutter_consware/domain/model/user_model.dart';
import 'package:flutter_consware/domain/repository/auth_repository.dart';
import 'package:flutter_consware/domain/repository/db_repository.dart';
import 'package:flutter_consware/domain/validator/validator.dart';



enum AuthStatus{
  Uninitialized,
  Authenticated,
  Authenticating,
  UnAunthenticated
}

enum SignUpStatus{
  Uninitialized,
  Registering,
  Registered,
  UnRegistered
}


class AuthCaseController extends ChangeNotifier with Validator{

  final AuthRespositoryInterface authRespositoryInterface;
  final DbRepositoryInterface  dbRepositoryInterface;
  final userPreference =  UserPreference();

  String _email = "";
  String _password = "";
  String _error = '';
  AuthStatus _authStatus = AuthStatus.Uninitialized;
  SignUpStatus _signUpStatus = SignUpStatus.Uninitialized;


  UserCredential? _usercredential; 

  AuthCaseController({ required this.authRespositoryInterface, required this.dbRepositoryInterface});

  

  String get typedEmail => _email;
  String get typedPassword => _password;
  String get error => _error;
  AuthStatus get authStatus => _authStatus;
  SignUpStatus get signUpStatus => _signUpStatus;
  UserCredential get userCredential => _usercredential!;

    /* En el apartado de los sets lo que se hace es asignarle lo que viene del metodo a la propiedad y posteriormente notificar*/
   set typedEmail(String email) {
     _email = email.trim();
     notifyListeners();
   }

   set typedPassword(String password) {
     _password = password.trim();
     notifyListeners();
   }

   set error(String error) {
     _error = error;
   }

   void clearFields(){
     _email = '';
     _password = '';
     notifyListeners();
   }

    // Cuando se hace uso del metodo se inicia sesion y se cambia el status para interactuar con la vista

   Future<void> handleSignIn() async{
     try {
       _authStatus = AuthStatus.Authenticating;
       notifyListeners();
       final UserCredential credential = await authRespositoryInterface.signInWithCredentials(
         UserModel(email: _email, password: _password)
       );

       _usercredential = credential;

       _authStatus = AuthStatus.Authenticated;

        userPreference.loginToken = _usercredential!.user!.uid;

       notifyListeners();

     } catch (e) {
       print("====> Error sign in: $e");
       _authStatus = AuthStatus.UnAunthenticated;
       
       if("$e".contains("user-not-found")) {
         error = "There is no user record corresponding to this identifier"; 
       } else if ("$e".contains("wrong-password") ){
         error = "The password is invalid or the user does not have a password.";
       } else {
         error = "Something went wrong contact support";
       }
       notifyListeners();

     }
     
   }
    // Cuando se hace uso del metodo se registra y se cambia el status para interactuar con la vista

   Future<void> handleSignUp() async{
     try {
       _signUpStatus = SignUpStatus.Registering;
       notifyListeners();
       final UserCredential credential = await authRespositoryInterface.signUpWithCredentials(
           UserModel(email: _email,password: _password)
       );
      
      _usercredential = credential;
      userPreference.loginToken = _usercredential!.user!.uid;
      _signUpStatus = SignUpStatus.Registered;

      await dbRepositoryInterface.nuevoUsuario(_email, _usercredential!.user!.uid);


       notifyListeners();

     } catch (e) {
       print("====> Error sign up: $e");
       _signUpStatus = SignUpStatus.UnRegistered;

       if("$e".contains("email-already-in-use")){
         error = "The email address is already in use by another account.";
       }
       notifyListeners();

     }
     
   }


   Future<void> handleSingOut() async{
     try {
       await authRespositoryInterface.signOut();
       userPreference.loginToken = "";
       clearFields();
     } catch (e) {
       print("Error: $e");
     }
   }

  

}