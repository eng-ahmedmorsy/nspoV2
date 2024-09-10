import 'package:nspo/Feauters/AttendanceEmployee/Presentation/ViewModel/attendance_employee_cubit.dart';
import 'package:nspo/Feauters/Login/Presentation/ModelView/login_cubit.dart';
import 'package:nspo/Feauters/MainScreenView/persentation/ViewModel/main_screen_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:nspo/Feauters/RegAttendanceOnline/persentation/ViewModel/main_screen_cubit.dart';
import 'package:nspo/Feauters/RegNewLocationRequest/Presention/Views/ViewModel/reg_new_location_request_cubit.dart';

import 'Core/servies/remoteConfig.dart';
import 'Core/utils/app_router.dart';
import 'Core/utils/bloc_observer.dart';
import 'package:permission_handler/permission_handler.dart';

import 'Feauters/ChangePhoneRequset/Presentation/ViewModel/requset_change_phone_cubit.dart';
import 'Feauters/RegAttendanceOffline/persentation/ViewModel/RegAttendanceOfflineCubit.dart';
import 'Feauters/UnsentAttendance/Presentation/ViewModel/unsent_attendance_cubit.dart';
import 'Feauters/profile/features/presentation/ModelView/reset_password_cubit.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await RemoteConfigService.instance.initialize();
  runApp(const MyApp());

  Bloc.observer = MyBlocObserver();
}

Future<void> _requestPermissions() async {
  // Request location permissions
  var locationStatus = await Permission.location.status;
  if (!locationStatus.isGranted) {
    await Permission.location.request();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    _requestPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginCubit(),
          ),
          BlocProvider(
            create: (context) => MainScreenCubit(),
          ),
          BlocProvider(
            create: (context) => RegAttendanceOnlineCubit(context.read<MainScreenCubit>()),
          ),
          BlocProvider(
            create: (context) => AttendanceEmployeeCubit(),
          ),
          BlocProvider(
            create: (context) => RequestChangePhoneCubit(),
          ),
          BlocProvider(
            create: (context) =>
                RegAttendanceOfflineCubit(context.read<MainScreenCubit>()),
          ),
          BlocProvider(
            create: (context) =>
                UnsentAttendanceCubit(context.read<MainScreenCubit>()),
          ),
          BlocProvider(
            create: (context) => ResetPasswordCubit(),
          ),
          BlocProvider(
            create: (context) => RegNewLocationRequestCubit(),
          ),
        ],
        child: MaterialApp.router(
          title: 'HR LOCATION',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Janna',
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
          ),
          routerConfig: AppRouter.router,
        ));
  }
}
