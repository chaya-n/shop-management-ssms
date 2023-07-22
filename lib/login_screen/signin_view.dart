import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/login_screen/firebaseAuth_handler.dart';
import 'package:shop_management/models/user/user_model.dart';
import 'package:shop_management/shared_widgets/snackbars.dart';
import 'package:shop_management/user/user_origin.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final emailController = TextEditingController();
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 48.0),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 48.0),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 48.0),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () async {
                Auth a = Auth();
                UserModel user = UserModel(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  phone: phoneController.text,
                  isAdmin: false,
                  cartItems: [],
                  email: emailController.text,
                  password: passwordController.text,
                );

                try {
                  final userSignedIn = await a.signUpNewUser(
                      emailController.text,
                      passwordController.text,
                      context,
                      ref);
                  if (userSignedIn != null) {
                    FirestoreHandler().addUserToFirestore(user);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(CustomSnackBars.successSnackBar);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(CustomSnackBars.failureSignInSnackBar);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: const Text(
                'Sign In',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
