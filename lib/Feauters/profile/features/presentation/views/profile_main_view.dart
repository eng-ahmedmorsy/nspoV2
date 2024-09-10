import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nspo/Feauters/profile/features/presentation/views/profile_view_body.dart';

class ProfileMainView extends StatelessWidget {
  const ProfileMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        centerTitle: true,
      ),
      body: const ProfileViewBody(),
    );
  }
}
