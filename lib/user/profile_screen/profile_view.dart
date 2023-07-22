import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shop_management/firestore_handler.dart';
import 'package:shop_management/login_screen/firebaseAuth_handler.dart';
import 'package:shop_management/models/user/user_model.dart';
import 'package:shop_management/shared_widgets/colours.dart';
import 'package:shop_management/shared_widgets/snackbars.dart';

class ProfileView extends ConsumerWidget {
  final UserModel user;
  const ProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Expanded(
              flex: 2,
              child: Text(
                'Sign Out',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  try {
                    FirestoreHandler().signOutCurrentUser().then((value) =>
                        ScaffoldMessenger.of(context)
                            .showSnackBar(CustomSnackBars.successSnackBar));
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(CustomSnackBars.failureSnackBar);
                  }
                },
                child: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Flexible(
              flex: 1,
              child: Text(
                'First Name',
                style: TextStyle(
                    color: CustomColours.primaryBrown,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
            ),
            Flexible(
              flex: 3,
              child: Text(
                user.firstName.toString(),
                style: const TextStyle(
                    color: CustomColours.primaryBrown,
                    fontSize: 26,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Last Name',
              style: TextStyle(
                  color: CustomColours.primaryBrown,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
            Text(
              user.lastName.toString(),
              style: const TextStyle(
                  color: CustomColours.primaryBrown,
                  fontSize: 26,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Phone',
              style: TextStyle(
                  color: CustomColours.primaryBrown,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
            Text(
              '+91 ${user.phone}'.toString(),
              style: const TextStyle(
                  color: CustomColours.primaryBrown,
                  fontSize: 26,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Email',
              style: TextStyle(
                  color: CustomColours.primaryBrown,
                  fontSize: 20,
                  fontWeight: FontWeight.w300),
            ),
            Text(
              user.email.toString(),
              style: const TextStyle(
                  color: CustomColours.primaryBrown,
                  fontSize: 26,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
