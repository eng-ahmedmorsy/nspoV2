class RequestChangePhone {
  int? id;
  bool? isAccepted;
  String? notes;
  String? newDeviceId;
  String ? requestDate;
  int? personId;

  RequestChangePhone({this.id, this.isAccepted, this.notes, this.newDeviceId, this.requestDate, this.personId});

  RequestChangePhone.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isAccepted = json['isAccepted'];
    notes = json['notes'];
    newDeviceId = json['newDeviceId'];
    requestDate = json['requestDate'];
    personId = json['personId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['isAccepted'] = isAccepted;
    data['notes'] = notes;
    data['newDeviceId'] = newDeviceId;
    data['requestDate'] = requestDate;
    data['personId'] = personId;
    return data;
  }
}
