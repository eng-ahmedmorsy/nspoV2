import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Feauters/profile/features/presentation/ModelView/reset_password_cubit.dart';

import '../../../../../../Core/Widgets/button_custom.dart';

class BtnLogout extends StatelessWidget {
  const BtnLogout({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ResetPasswordCubit>();
    return  ButtonCustom(
      label: "تسجيل خروج",
      onTap: () => cubit.logout(context),
      color: Colors.teal.shade300,
      colorText: Colors.white,
      borderRadius: BorderRadius.circular(5),
      width: 200,
      height: 50,
    );


  }
}
