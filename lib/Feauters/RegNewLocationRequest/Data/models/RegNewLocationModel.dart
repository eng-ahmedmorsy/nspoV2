class RegNewLocationRequestModel {
  int ? id;
  String? nameProject;
  String? notets;
  String? coord;
  int? personId;
  String ? date;
  bool ? status;

  RegNewLocationRequestModel(
      {this. id,this.nameProject, this.notets, this.coord, this.personId});

  RegNewLocationRequestModel.fromJson(Map<String, dynamic> json) {
    nameProject = json['nameProject'];
    notets = json['notets'];
    coord = json['coord'];
    personId = json['personId'];
    date = json['date'];
    status = json['status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameProject'] = this.nameProject;
    data['notets'] = this.notets;
    data['coord'] = this.coord;
    data['personId'] = this.personId;
    return data;
  }
}
