import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../Core/Widgets/button_custom.dart';
import '../../ModelView/reset_password_cubit.dart';

class BtnChangePassword extends StatelessWidget {
  const BtnChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ResetPasswordCubit>();
    return  ButtonCustom(
      label: " تغيير",
      onTap: () =>
        cubit.resetPassword(),

      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
      width: 200,
      height: 50,
    );


  }
}
