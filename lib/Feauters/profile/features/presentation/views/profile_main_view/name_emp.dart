import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ModelView/reset_password_cubit.dart';

class NameEmp extends StatelessWidget {
  const  NameEmp({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ResetPasswordCubit>();
    return BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
      builder: (context, state) {
        return Text(
          cubit.nameEmp ?? '',
          style: const TextStyle(fontSize: 20),
        );
      },
    );
  }
}
