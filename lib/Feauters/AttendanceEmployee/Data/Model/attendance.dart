class AttendanceEmployee {
  final String date;
  final Attendance? attendance;

  AttendanceEmployee({
    required this.date,
    this.attendance,
  });

  factory AttendanceEmployee.fromJson(Map<String, dynamic> json) {
    return AttendanceEmployee(
      date: json['date'] as String,
      attendance: json['attendance'] != null
          ? Attendance.fromJson(json['attendance'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'attendance': attendance?.toJson(),
    };
  }
}

class Attendance {
  final int middleDayCount;
  final Attend? attend;
  final Attend? leave;
  final List<Attend>? middleDay;

  Attendance({
    required this.middleDayCount,
    this.attend,
    this.leave,
    this.middleDay,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      middleDayCount: json['middleDayCount'] as int,
      attend: json['attend'] != null ? Attend.fromJson(json['attend']) : null,
      leave: json['leave'] != null ? Attend.fromJson(json['leave']) : null,
      middleDay: json['middleDay'] != null
          ? (json['middleDay'] as List)
          .map((e) => Attend.fromJson(e as Map<String, dynamic>))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'middleDayCount': middleDayCount,
      'attend': attend?.toJson(),
      'leave': leave?.toJson(),
      'middleDay': middleDay?.map((e) => e.toJson()).toList(),
    };
  }
}

class Attend {
  final String status;
  final String hour;

  Attend({
    required this.status,
    required this.hour,
  });

  factory Attend.fromJson(Map<String, dynamic> json) {
    return Attend(
      status: json['status'] as String,
      hour: json['hour'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'hour': hour,
    };
  }
}
