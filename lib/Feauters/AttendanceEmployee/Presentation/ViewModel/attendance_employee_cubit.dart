import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Data/Repo/attenadanceEmployeeRepo.dart';
import 'package:nspo/Feauters/AttendanceEmployee/Data/Repo/attenadanceEmployeeRepoImpl.dart';

import '../../../../Core/servies/sharedPerf.dart';
import '../../Data/Model/attendance.dart';

part 'attendance_employee_state.dart';

class AttendanceEmployeeCubit extends Cubit<AttendanceEmployeeState> {
  AttendanceEmployeeCubit() : super(AttendanceEmployeeInitial());
  String? selectedMonth;
  String? selectedYear;

  List<AttendanceEmployee> attendancesEmployee = [];

  final Map<String, int> months = {
    "يناير": 1,
    "فبراير": 2,
    "مارس": 3,
    "أبريل": 4,
    "مايو": 5,
    "يونيو": 6,
    "يوليو": 7,
    "أغسطس": 8,
    "سبتمبر": 9,
    "أكتوبر": 10,
    "نوفمبر": 11,
    "ديسمبر": 12,
  };

  final List<String> years =
      List.generate(100, (index) => (DateTime.now().year - index).toString());

  void getMonthYear() {
    final now = DateTime.now();
    // select month now
    selectedMonth =
        months.keys.firstWhere((element) => months[element] == now.month);

    selectedYear = now.year.toString();
  }

  void changeMonth(String month) {
    selectedMonth = month;
    emit(ChangeMonthState());
  }

  void changeYear(int year) {
    selectedYear = year.toString();
    emit(ChangeYearState());
  }

  getAttendanceEmployee() async {
    print(selectedYear);
    print(months[selectedMonth!]);
    emit(LoadingGetAttendanceState());
    int personId = await getPersonalId();
    AttendanceEmployeeRepoImpl attendanceEmployee =
        AttendanceEmployeeRepoImpl();
    attendanceEmployee
        .getAttendanceEmployee(
            personId: personId,
            month: months[selectedMonth]!,
            year: selectedYear!)
        .then((value) {
      value.fold((l) {
        emit(ErrorGetAttendanceState(l));
      }, (r) {
        attendancesEmployee = r;

        emit(SuccessState());
      });
    });
  }

  Future<int> getPersonalId() async {
    Map<String, dynamic>? data =
        await SharedPreferencesService.retrieveMap("infoEmployee");

    return data!["id"];
  }
}
