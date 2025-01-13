import 'package:cure_near/logic/login_screen/login_bloc.dart';
import 'package:cure_near/logic/profile_screen/profile_screen_bloc.dart';
import 'package:cure_near/logic/profile_setup_screen/profile_setup_bloc.dart';
import 'package:cure_near/logic/signUp_screen/signUp_bloc.dart';
import 'package:cure_near/logic/splash_screen/splash_bloc.dart';
import 'package:cure_near/logic/tab_bar_screen/tab_bar_bloc.dart';
import 'package:cure_near/routes/go_route.dart';
import 'package:cure_near/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'logic/forgot_password_screen/forgot_password_bloc.dart';
import 'logic/home_screen/home_bloc.dart';
import 'logic/search_bar/search_bar_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper().initPrefs(); // Initialize shared preferences
  runApp(const MyApp());
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
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<TabBarBloc>(
          create: (context) => TabBarBloc(),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(),
        ),
        BlocProvider<ProfileScreenBloc>(
          create: (context) => ProfileScreenBloc(),
        ),
        BlocProvider<ForgotPasswordBloc>(
          create: (context) => ForgotPasswordBloc(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus!.unfocus();
            }
          },
          child: MaterialApp.router(
            theme: ThemeData(
              primaryColor: Colors.teal,
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: Colors.teal,
              ),
            ),
            routerDelegate: router.routerDelegate,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
          ),
        ),
      ),
    );
  }
}
