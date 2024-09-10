

class AttendanceEmpToday {
  String? timeIn;
  int? countRegInMiddleDay;
  String? timeOut;
  String? totalTimes;

  AttendanceEmpToday(
      {this.timeIn, this.countRegInMiddleDay, this.timeOut, this.totalTimes});

  AttendanceEmpToday.fromJson(Map<String, dynamic> json) {
    timeIn = json['timeIn'];
    countRegInMiddleDay = json['countRegInMiddleDay'];
    timeOut = json['timeOut'];
    totalTimes = json['totalTimes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeIn'] = this.timeIn;
    data['countRegInMiddleDay'] = this.countRegInMiddleDay;
    data['timeOut'] = this.timeOut;
    data['totalTimes'] = this.totalTimes;
    return data;
  }
}
