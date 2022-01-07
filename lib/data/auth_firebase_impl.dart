

import 'package:flutter_consware/domain/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_consware/domain/repository/auth_repository.dart';

class AuthFirebaseImpl extends AuthRespositoryInterface {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signInWithCredentials(UserModel login) async{
    return _firebaseAuth.signInWithEmailAndPassword(
      email: login.email,
      password: login.password
    );
  }

   @override
  Future<UserCredential> signUpWithCredentials(UserModel user) async{
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
  }

  @override
  Future<void> signOut() async{
    return await _firebaseAuth.signOut();
  }

}