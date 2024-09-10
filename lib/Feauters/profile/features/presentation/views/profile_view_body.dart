import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Feauters/profile/features/presentation/views/profile_main_view/card_rest_password.dart';
import 'package:nspo/Feauters/profile/features/presentation/views/profile_main_view/image_person.dart';
import 'package:nspo/Feauters/profile/features/presentation/views/profile_main_view/name_emp.dart';

import '../../../../../Core/Widgets/Dailog.dart';
import '../ModelView/reset_password_cubit.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  void initState() {
    context.read<ResetPasswordCubit>().getNameEmployee();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordError) {
            DailogError(context, message: state.error);
          }
          if (state is ResetPasswordSuccess) {
            DailogError(context, message: "تم تغيير كلمة المرور بنجاح",barrierDismissible: false ,nameBtn: "حسنا", onPressed: () {
              context.read<ResetPasswordCubit>().logout(context);
            });
          }
        },
        builder: (context, state) {

          if (state is ResetPasswordLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                ImagePerson(),
                SizedBox(
                  height: 20,
                ),
                NameEmp(),
                SizedBox(
                  height: 20,
                ),
                // BtnLogout(),
                SizedBox(
                  height: 20,
                ),
                CardRestPassword(),
              ],
            ),
          );
        },
      ),
    );
  }
}
