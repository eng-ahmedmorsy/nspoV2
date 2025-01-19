import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nspo/Core/utils/app_router.dart';
import 'package:nspo/Feauters/UploadImageFace/presentation/Views/widgets/btn_capture.dart';

import '../../../../../Core/Widgets/Dailog.dart';
import '../../ModelImage/upload_face_cubit.dart';

class ShowImageFace extends StatelessWidget {
  const ShowImageFace({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<UploadFaceCubit>();
    return BlocConsumer<UploadFaceCubit, UploadFaceState>(
      listener: (context, state) {
        if (state is SendImageErrorState) {
          DailogError(context,
              message: "حدث خطأ اثناء رفع الصورة برجاء اعادة المحاولة",
              nameBtn: "حاول مرة اخري", onPressed: () {
            cubit.sendImageFace();
            Navigator.pop(context);
          });
        } else if (state is SendImageSuccessState) {
          DailogError(context, message: "تم رفع الصورة بنجاح", nameBtn: "موافق",
              onPressed: () {
                context.pushReplacement(AppRouter.mainScreenView);
          });
        }
      },
      builder: (context, state) {
        if (state is SendImageLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'رفع صورة تحقق شخصية',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 20),
            Image.file(
              File(cubit.imagePath),
            ),
            SizedBox(height: 20),
            Text(
              'يرجى أخذ صورة واضحة لتسهيل عملية التحقق.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BtnCapture(
                    nameBtn: "إعادة التقاط",
                    onPressed: () => cubit.repeatTakeImage()),
                BtnCapture(
                    nameBtn: "ارسال صوره",
                    onPressed: () => cubit.sendImageFace()),
              ],
            )
          ],
        );
      },
    );
  }
}
