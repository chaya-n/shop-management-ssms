import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signUpNewUser(String email, String password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (result.user == null) {
      print('Null user');
    }
  }

  Future<void> logInUser(
      String email, String password, BuildContext context) async {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    if (result.user != null && context.mounted) {
      context.go('/UserHome');
    }
  }
}
