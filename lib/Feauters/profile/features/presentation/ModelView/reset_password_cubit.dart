import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import '../../../../../Core/servies/sharedPerf.dart';
import '../../../../../Core/utils/app_router.dart';
import '../../Data/Models/reset_password.dart';
import '../../Data/Repoistory/reset_password_repo_impl.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  String nameEmp = "";
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();

  getNameEmployee() async {
    Map<String, dynamic>? data =
        await SharedPreferencesService.retrieveMap("infoEmployee");

    nameEmp = data!["name"];
    emit(GetNameEmployee());
  }

  Future<void> resetPassword() async {
    emit(ResetPasswordLoading());
    RestPasswordRepoImpl restPasswordRepoImpl = RestPasswordRepoImpl();
    int personId = await getPersonalId();
    await restPasswordRepoImpl
        .resetPassword(
            resetPasswordModel: ResetPasswordModel(
              idPerson: personId,
                oldPassword: oldPassword.text, newPassword: newPassword.text))
        .then((value) {
      value.fold((l) {
        emit(ResetPasswordError(l));
      }, (r) {

        emit(ResetPasswordSuccess());
      });
    });
  }

  Future<int> getPersonalId() async {
    Map<String, dynamic>? data =
    await SharedPreferencesService.retrieveMap("infoEmployee");

    return data!["id"];
  }
  void logout(BuildContext context) async {
    await SharedPreferencesService.delete("infoEmployee");
    context.pushReplacement(AppRouter.mainScreenView);
  }
}
