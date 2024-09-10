import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Widgets/button_custom.dart';
import '../../ModelView/login_cubit.dart';

class BtnLogin extends StatelessWidget {
  const BtnLogin({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LoginCubit>();
    return  ButtonCustom(
      label: "تسجيل الدخول",
      onTap: () => {
        cubit.loginEmployee(),
      },
      color: Colors.green.shade900,
      colorText: Colors.white,
      borderRadius: BorderRadius.circular(5),
      width: 200,
      height: 50,
    );
  }
}
