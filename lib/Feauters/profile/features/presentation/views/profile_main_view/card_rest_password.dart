import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../ModelView/reset_password_cubit.dart';
import 'cahngePasswordBtn.dart';

class CardRestPassword extends StatelessWidget {
  const CardRestPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<ResetPasswordCubit>();
    return               Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        padding:
        const EdgeInsets.symmetric( horizontal: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.teal.shade300,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric( horizontal: 8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'تغيير كلمة المرور',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,
                child:  TextField(
                  controller: cubit.oldPassword,
                  decoration: const InputDecoration(
                    labelText: 'الباسورد القديم',
                    // none: Removes the underline
                    border: InputBorder.none,

                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.white,

                child:  TextField(
                  controller:cubit.newPassword ,
                  decoration: const InputDecoration(
                    labelText: 'الباسورد الجديد',
                    border: InputBorder.none,

                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              const BtnChangePassword(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    )
    ;
  }
}
