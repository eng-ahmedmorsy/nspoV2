import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:nspo/Core/servies/checkLogin.dart';
import 'package:nspo/Feauters/Login/Presentation/View/loginMainView.dart';
import 'package:nspo/Feauters/MainScreenView/persentation/Views/mainScreenView.dart';
import 'package:nspo/Feauters/profile/features/presentation/views/profile_main_view.dart';

class AppRouter {
  static String mainScreenView = '/';
  static String profileView = '/profileView';
  static String  mainPage = '/mainPage';



  static final GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: mainScreenView,
      builder: (BuildContext context, GoRouterState state) {
        return FutureBuilder<bool>(
          future: CheckLogin.isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data == true) {
              return const MainScreenView();
            } else {
              return const LoginMainView();
            }
          },
        );
      },
    ),
    GoRoute(
    path: profileView,
    builder: (BuildContext context, GoRouterState state) {
      return const ProfileMainView();
    },
  ), GoRoute(
    path: mainPage,
    builder: (BuildContext context, GoRouterState state) {
      return const MainScreenView();
    },
  ),
  ]);
}
