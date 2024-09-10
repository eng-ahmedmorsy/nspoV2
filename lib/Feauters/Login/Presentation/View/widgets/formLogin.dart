import 'dart:io';

import 'package:flutter/services.dart';
import 'package:nspo/Core/extension/MediaQueryValues.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Widgets/Dailog.dart';
import '../../ModelView/login_cubit.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    double defaultFontSize = 14;
    double defaultIconSize = 17;
    var cubit = context.read<LoginCubit>();
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is UpdatesAvailable) {
          DailogError(
            context,
            message: " يوجد تحديث جديد برجاء ضغط علي زر تحديث ودخول علي تطبيق مرة اخري",
            barrierDismissible: false,
            nameBtn: "تحديث",
            onPressed: () => exit(0),
          );
        }
      },
      child: Column(
        children: [
          SizedBox(
            width: context.width * 0.8,
            child: TextField(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
              controller: cubit.userNameController,
              showCursor: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                prefixIcon: Icon(
                  Icons.person,
                  color: const Color(0xFF666666),
                  size: defaultIconSize,
                ),
                fillColor: const Color(0xFFF2F3F5),
                hintStyle: TextStyle(
                    color: const Color(0xFF666666), fontSize: defaultFontSize),
                hintText: "اسم المستخدم",
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: context.width * 0.8,
            child: TextField(
              textAlign: TextAlign.center,
              controller: cubit.passwordController,
              showCursor: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                filled: true,
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: const Color(0xFF666666),
                  size: defaultIconSize,
                ),
                suffixIcon: Icon(
                  Icons.remove_red_eye,
                  color: const Color(0xFF666666),
                  size: defaultIconSize,
                ),
                fillColor: const Color(0xFFF2F3F5),
                hintStyle: TextStyle(
                  color: const Color(0xFF666666),
                  fontSize: defaultFontSize,
                ),
                hintText: "كلمة المرور",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
