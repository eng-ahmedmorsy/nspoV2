import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nspo/Core/models/AttendanceRecord.dart';
import 'package:nspo/Feauters/UnsentAttendance/Data/Repo/UnsentAttendanceRepoImpl.dart';

import '../../../../Core/servies/DbHelper.dart';
import '../../../../Core/servies/sharedPerf.dart';
import '../../../MainScreenView/persentation/ViewModel/main_screen_cubit.dart';
import '../../../RegAttendanceOnline/persentation/Data/Models/RegAttendaceModel.dart';
import '../../../RegAttendanceOnline/persentation/Data/Repoistry/AttendanceRepoImpl.dart';

part 'unsent_attendance_state.dart';

class UnsentAttendanceCubit extends Cubit<UnsentAttendanceState> {
  UnsentAttendanceCubit(this.mainScreenCubit)
      : super(UnsentAttendanceInitial());
  final MainScreenCubit? mainScreenCubit;

  List<AttendanceRecord> allUnsentAttendance = [];

  getUnsentAttendance() async {
    emit(UnsentAttendanceLoading());
    try {
      UnsentAttendanceRepoImpl unsentAttendanceRepoImpl =
          UnsentAttendanceRepoImpl();
      int personId = await getPersonalId();
      await unsentAttendanceRepoImpl
          .getUnsentAttendance(personId)
          .then((value) {
        value.fold((l) {
          emit(UnsentAttendanceError(l));
        }, (r) {
          allUnsentAttendance = r;
          emit(UnsentAttendanceLoaded());
        });
      });

      emit(UnsentAttendanceLoaded());
    } catch (e) {
      emit(UnsentAttendanceError(e.toString()));
    }
  }

  Future<int> getPersonalId() async {
    Map<String, dynamic>? data =
        await SharedPreferencesService.retrieveMap("infoEmployee");

    return data!["id"];
  }

  Future<void> sendAttendance(AttendanceRecord attendanceRecord) async {
    emit(SendAttendanceLoading());
    AttendanceRepoImpl attendanceRepoImpl = AttendanceRepoImpl();
    Map<String, dynamic> data = attendanceRecord.toJson();

    RegAttendanceModel regAttendanceModel = RegAttendanceModel.fromJson(data);

    final result =
        await attendanceRepoImpl.addAttendanceData(regAttendanceModel);

    result.fold((l) {
      emit(SendAttendanceError(l));
    }, (r) {
      DatabaseHelper databaseHelper = DatabaseHelper();
      databaseHelper.updateSent(attendanceRecord.id!);
      mainScreenCubit!.getCountUnsentAttendance();
      emit(SendAttendanceLoaded());
    });
  }

  deleteAttendance(int id) async {
    emit(UnsentAttendanceLoading());
    DatabaseHelper databaseHelper = DatabaseHelper();
    await databaseHelper.delete(id);
    getUnsentAttendance();
    mainScreenCubit?.getCountUnsentAttendance();
    emit(DeleteAttendState());


  }
}
