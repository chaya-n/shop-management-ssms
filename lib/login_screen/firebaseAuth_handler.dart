import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_management/admin/add_product_screen/add_product_view.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/user/user_origin.dart';

final userImageProvider = StateProvider<String?>((ref) => null);

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> onAuthStateChanged() {
    return auth.authStateChanges();
  }

  Future<String?> getUserImage(UserCredential user) async {
    return user.user!.photoURL;
  }

  Future<User?> signUpNewUser(String email, String password,
      BuildContext context, WidgetRef ref) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    if (result.user != null && context.mounted) {
      String? photoUrl = await getUserImage(result);
      ref.read(userImageProvider.notifier).state = photoUrl;
      Navigator.of(context).pop();
      Navigator.popAndPushNamed(context, '/UserOrigin');
    }
    return result.user;
  }

  Future<int> logInUser(String email, String password, BuildContext context,
      WidgetRef ref) async {
    await FirestoreHandler().addUserIdToStorage(email, ref);
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        String? photoUrl = await getUserImage(userCredential);
        ref.read(userImageProvider.notifier).state = photoUrl;
      } else {
        await FirestoreHandler().deleteUserIdFromStorage();
      }
    } on FirebaseAuthException catch (e) {
      return -1;
    }
    return 1;
  }

  Future<void> signOutCurrentUser() async {
    await auth.signOut();
  }
}
