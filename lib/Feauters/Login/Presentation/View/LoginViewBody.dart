import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:nspo/Core/Widgets/Logo.dart';
import 'package:nspo/Feauters/Login/Presentation/View/widgets/TitleCompany.dart';
import 'package:nspo/Feauters/Login/Presentation/View/widgets/btnLogin.dart';
import 'package:nspo/Feauters/Login/Presentation/View/widgets/formLogin.dart';
import 'package:flutter/material.dart';

import '../../../../Core/Widgets/button_custom.dart';
import '../ModelView/login_cubit.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  @override
  void initState() {
    context.read<LoginCubit>().checkUpdate();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          width: double.infinity,
          color: Colors.white70,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Logo(),

              // SizedBox for spacing
              SizedBox(
                height: 15,
              ),

              LoginForm(),

              // SizedBox for spacing
              SizedBox(
                height: 25,
              ),

              BtnLogin(),

              SizedBox(height: 50),

              TitleCompany(),
            ],
          ),
        ),
      ),
    );
  }
}
