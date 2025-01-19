import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Feauters/FaceDetect/Presentation/ModelView/face_detect_cubit.dart';

import '../../../../FaceDetect/Presentation/Views/face_detect.dart';
import '../../ModelImage/upload_face_cubit.dart';
import 'btn_capture.dart';

class TakeCaptureCard extends StatelessWidget {
  const TakeCaptureCard({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<UploadFaceCubit>();
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
        cubit.isAccepted
            ? BlocBuilder<FaceDetectCubit, FaceDetectState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      FaceDetectorView(),
                      cubit.faceDetectCubit.faceDetected
                          ? IconButton(
                              onPressed: () => cubit.ShowImage(),
                              icon: Icon(Icons.camera_alt_outlined,
                                  color: Colors.teal, size: 50))
                          : SizedBox(),
                    ],
                  );
                },
              )
            : Image.asset(
                'assets/images/face.png',
                height: 200,
                width: 200,
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'يهدف هذا الإجراء إلى استخدام تقنية التعرف على الوجه للتحقق من هوية المستخدم ومطابقة وجهه في كل مرة يتم فيها إرسال بيانات الحضور.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 20),
        Text(
          'نحن ملتزمون بحماية بياناتك وعدم مشاركتها مع أي جهة خارجية.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30),
        BtnCapture(nameBtn: !cubit.isAccepted? 'التقاط الصورة':'الغاء', onPressed: () => cubit.changeAccepted()),
      ],
    );
  }
}
