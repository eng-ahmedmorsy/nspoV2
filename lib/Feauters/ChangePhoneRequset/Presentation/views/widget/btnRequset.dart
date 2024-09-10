import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Core/Widgets/Dailog.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Presentation/ViewModel/requset_change_phone_cubit.dart';

import '../../../../../Core/Widgets/button_custom.dart';

class BtnRequset extends StatelessWidget {
  const BtnRequset({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RequestChangePhoneCubit>();
    return BlocConsumer<RequestChangePhoneCubit, RequestChangePhoneState>(
      listener: (context, state) {
        if (state is AddRequestChangePhoneError) {
          DailogError(context, message: state.error);
        }
      },
      builder: (context, state) {
        if (state is AddRequestChangePhoneLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ButtonCustom(
          label: "تسجيل طلب",
          onTap: () =>
          {
            cubit.addRequest(),
          },
          color: Colors.teal.shade300,
          colorText: Colors.white,
          borderRadius: BorderRadius.circular(5),
          width: 200,
          height: 50,
        );
      },
    );
  }
}
