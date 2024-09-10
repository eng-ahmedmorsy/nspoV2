class ResetPasswordModel {
  int? idPerson;
  String? oldPassword;
  String? newPassword;

  ResetPasswordModel({this.idPerson, this.oldPassword, this.newPassword});



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idPerson'] = idPerson;
    data['oldPassword'] = oldPassword;
    data['newPassword'] = newPassword;
    return data;
  }
}