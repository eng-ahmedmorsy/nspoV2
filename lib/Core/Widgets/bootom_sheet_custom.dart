import 'package:flutter/material.dart';

import '../constance/colors.dart';

void showBottomSheetCustom(BuildContext context, Widget child) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return child;
    },
  );
}
