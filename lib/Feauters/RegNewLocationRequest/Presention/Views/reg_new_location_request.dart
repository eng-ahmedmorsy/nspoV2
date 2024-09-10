import 'package:flutter/material.dart';
import 'package:nspo/Feauters/RegNewLocationRequest/Presention/Views/widget/FormRequset.dart';
import 'package:nspo/Feauters/RegNewLocationRequest/Presention/Views/widget/notes.dart';

import 'widget/LastRequset.dart';
import 'widget/btnRequset.dart';

class RegNewLocationRequest extends StatelessWidget {
  const RegNewLocationRequest({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FormRequest(),
            SizedBox(
              height: 20,
            ),
        
            Notes(),
        
            SizedBox(
              height: 20,
            ),
            BtnRequest(),
            SizedBox(
              height: 20,
            ),
            LastRequest()
        
        
        
          ],
        ),
      ),
    );
  }
}
