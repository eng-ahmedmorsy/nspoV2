import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Presentation/views/widget/LastRequset.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Presentation/views/widget/btnRequset.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Presentation/views/widget/notes.dart';

import '../../../../Core/Widgets/border_label.dart';
import '../ViewModel/requset_change_phone_cubit.dart';

class ChangePhoneRequset extends StatelessWidget {
  const ChangePhoneRequset({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RequestChangePhoneCubit>();
    return   SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [


            const SizedBox(
              height: 20,
            ),
            const Text(
              'تقديم طلب تغيير  الهاتف',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            // NOTES : Add ChangePhoneRequset Form
            Directionality(
              textDirection: TextDirection.rtl,
              child: BorderWithLabel(
                color: Colors.teal,
                label: 'سبب',
                child: TextField(
                  minLines: 5,
                  maxLines: 10,
                  controller: cubit.noteController,
                  decoration: const InputDecoration(

                    border: InputBorder.none,

                    labelText: 'سبب تغيير الهاتف',

                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            // ADD TEXT NOTES
            const SizedBox(
              height: 20,
            ),
           const Notes(),

            const SizedBox(
              height: 20,
            ),
            const BtnRequset(),
            const SizedBox(
              height: 20,
            ),
            const LastRequest(),




          ],
        ),
      ),
    );
  }
}
