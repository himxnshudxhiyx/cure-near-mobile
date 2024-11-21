import 'package:cure_near/logic/login_screen/login_bloc.dart';
import 'package:cure_near/logic/profile_setup_screen/profile_setup_bloc.dart';
import 'package:cure_near/logic/signUp_screen/signUp_bloc.dart';
import 'package:cure_near/logic/splash_screen/splash_bloc.dart';
import 'package:cure_near/routes/go_route.dart';
import 'package:cure_near/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initSharedPref();
  runApp(
    // const AnnotatedRegion<SystemUiOverlayStyle>(
    //   value: SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent, // Make status bar transparent
    //     statusBarIconBrightness: Brightness.light, // Choose icon color, `dark` or `light`
    //   ),
    //   child: MyApp(),
    // ),
    const MyApp(),
  );
}

initSharedPref() async {
  await SharedPrefsHelper().initPrefs();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
          create: (context) => SplashBloc(router),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<SignUpBloc>(
          create: (context) => SignUpBloc(),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp.router(
          theme: ThemeData(
            primaryColor: Colors.teal,  // Set your primary color here
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.teal,  // Ensures primary color consistency
            ),
          ),
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
        ),
      ),
    );
  }
}
