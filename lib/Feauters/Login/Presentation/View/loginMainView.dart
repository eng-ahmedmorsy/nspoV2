import 'package:nspo/Core/Widgets/background_image.dart';
import 'package:nspo/Core/utils/app_router.dart';
import 'package:nspo/Feauters/MainScreenView/persentation/ViewModel/main_screen_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../Core/Widgets/Dailog.dart';
import '../ModelView/login_cubit.dart';
import 'LoginViewBody.dart';

class LoginMainView extends StatelessWidget {
  const LoginMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // اجعلها true لإعادة تحجيم المحتوى

      body: Center(
        child: SafeArea(
            child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginErrorMessage) {

                DailogError(
                  context,
                  message: state.error,
                );

            } else if (state is LoginSuccess) {
              context.pushReplacement(AppRouter.mainScreenView);
            }
          },
          builder: (context, state) {
            if (state is LoginLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const LoginViewBody();
          },
        )),
      ),
    );
  }
}
