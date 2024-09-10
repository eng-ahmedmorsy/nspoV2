import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Core/Widgets/border_label.dart';
import '../ViewModel/reg_new_location_request_cubit.dart';

class FormRequest extends StatelessWidget {
  const FormRequest({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegNewLocationRequestCubit>();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          // Container(
          //   padding: const EdgeInsets.all(10),
          //   decoration: BoxDecoration(
          //     color: Colors.teal,
          //     borderRadius: BorderRadius.circular(5),
          //   ),
          //   child: const Text('تسجيل مشروع لوكيشن مشروع جديد ',
          //       style: TextStyle(fontSize: 20, color: Colors.white)),
          // ),
          const SizedBox(
            height: 30,
          ),
          BorderWithLabel(
            color: Colors.teal,
            label: 'اسم المشروع',
            child: TextField(
              controller: cubit.nameProjectController,
              decoration: const InputDecoration(
                border: InputBorder.none,
       contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),

          BorderWithLabel(
            color: Colors.teal,
            label: 'وصف الموقع',
            child: TextField(
              minLines: 5,
              maxLines: 10,
              controller: cubit.noteController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(10),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
