import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_consware/domain/model/user_model.dart';

abstract class AuthRespositoryInterface{
  Future<UserCredential> signInWithCredentials(UserModel login); 
  Future<UserCredential> signUpWithCredentials(UserModel user);
  //Future<bool> verifyToken(int token);
  Future<void> signOut();
}