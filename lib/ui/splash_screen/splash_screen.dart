import 'package:cure_near/logic/splash_screen/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/splash_screen/splash_event.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    context.read<SplashBloc>().add(CheckUserSession());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(context) {
    return Stack(
      children: [
        Image.asset(
          'assets/Icon_Splash_Bg.png',
          width: MediaQuery.sizeOf(context).width,
          fit: BoxFit.fitWidth,
        ),
        Center(
          child: Image.asset(
            'assets/Ic_Logo.png',
          ),
        ),
      ],
    );
  }
}
