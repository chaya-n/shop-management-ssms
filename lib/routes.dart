import 'package:go_router/go_router.dart';
import 'package:shop_management/login_screen/login_view.dart';
import 'package:shop_management/login_screen/signin_view.dart';
import 'package:shop_management/main.dart';
import 'user/user_origin.dart';
import 'package:riverpod/riverpod.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
        routes: [
          GoRoute(
              path: '/UserHome',
              builder: (context, state) => const UserOrigin()),
          GoRoute(
              path: '/SignIn', builder: (context, state) => const SignInView()),
          // GoRoute(path: 'ProductPage', builder: (context, state) => ProductPage(email: "chayanhjain@gmail.com", product: product)),
        ]),
    // GoRoute(path: 'UserHome', builder: (context, state) => const UserOrigin()),
    // GoRoute(path: 'SignIn', builder: (context, state) => const SignInView())
  ],
);
