import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Core/Widgets/Dailog.dart';
import 'package:nspo/Core/Widgets/loading.dart';
import 'package:nspo/Feauters/RegNewLocationRequest/Presention/Views/ViewModel/reg_new_location_request_cubit.dart';

import '../../../../../Core/Widgets/button_custom.dart';
import '../../../../../Core/servies/ErrorLocateLocation.dart';

class BtnRequest extends StatelessWidget {
  const BtnRequest({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegNewLocationRequestCubit>();
    return BlocConsumer<RegNewLocationRequestCubit, RegNewLocationRequestState>(
      listener: (context, state) {
        if (state is AddRegNewLocationRequestError) {
          DailogError(context, message: state.error);
        }
        if (state is ErrorLocationState) {
          ShowDailogErrorLocationAndAutoTime(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is AddRegNewLocationRequestLoading) {
          return const Center(
            child: LoadingWidget(),
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
