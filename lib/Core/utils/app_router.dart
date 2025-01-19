import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:nspo/Core/servies/checkLogin.dart';
import 'package:nspo/Feauters/FaceDetect/Presentation/Views/face_detect.dart';
import 'package:nspo/Feauters/Login/Presentation/View/loginMainView.dart';
import 'package:nspo/Feauters/MainScreenView/persentation/Views/mainScreenView.dart';
import 'package:nspo/Feauters/profile/features/presentation/views/profile_main_view.dart';
import 'package:nspo/Feauters/UploadImageFace/presentation/Views/upload_image_face_view.dart';

class AppRouter {
  static String mainScreenView = '/';
  static String profileView = '/profileView';
  static String mainPage = '/mainPage';
  static String faceDetectPage = '/faceDetectView';
  static String uploadImageFaceView = '/UploadImageFaceView';

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
              return MainScreenView();
              return MainScreenView();
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
    ),
    GoRoute(
      path: uploadImageFaceView,
      builder: (BuildContext context, GoRouterState state) {
        return UploadImageFaceView();
      },
    ),
    GoRoute(
      path: mainPage,
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreenView();
      },
    ),
  ]);
}
