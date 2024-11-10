import 'package:cure_near/widgets/elevated_button_widget.dart';
import 'package:cure_near/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/login_screen/login_bloc.dart';
import '../../logic/login_screen/login_event.dart';
import '../../logic/login_screen/login_state.dart';
import '../../widgets/text_feild.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login Successful')),
              );
            } else if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Login Failed: ${state.errorMessage}')),
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _welcomeView(context),
                  AppTextField(
                    hintText: "Email",
                    controller: _emailController,
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.grey.shade700,),
                    keyboardType: TextInputType.emailAddress,
                    filled: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.sp),
                  AppTextField(
                    hintText: "Password",
                    controller: _passwordController,
                    obscureText: true,
                    filled: true,
                    prefixIcon: Icon(Icons.lock_outline_rounded, color: Colors.grey.shade700,),
                    suffixWidget: Icon(Icons.remove_red_eye_rounded, color: Colors.grey.shade700,),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.sp),
                  ElevatedButtonWidget(
                    onPressed: () {
                      context.read<LoginBloc>().add(LoginSubmitted(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ));
                    },
                    text: 'Sign In',
                  ),
                  if (state is LoginLoading) CircularProgressIndicator(),
                  _signUpAndForgot(context),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _welcomeView(context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight + 50),
            child: Image.asset(
              'assets/Ic_Logo.png',
              // height: 150.sp,
              color: Colors.black,
            ),
          ),
          const TextView(
            text: "Cure Near",
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
          SizedBox(
            height: 30.sp,
          ),
          const TextView(
            text: "Hi, Welcome Back!",
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
          SizedBox(
            height: 6.sp,
          ),
          TextView(
            text: "Hope you are doing fine.",
            fontWeight: FontWeight.w300,
            fontSize: 16,
            fontColor: Colors.grey.shade500,
          ),
          SizedBox(
            height: 18.sp,
          ),
        ],
      ),
    );
  }

  Widget _signUpAndForgot(context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          SizedBox(
            height: 30.sp,
          ),
          const TextView(
            text: "Forgot password?",
            // fontWeight: FontWeight.w500,
            fontSize: 15,
            fontColor: Colors.blue,
          ),
          SizedBox(
            height: 16.sp,
          ),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               TextView(
                text: "Don't have account yet? ",
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
               TextView(
                text: "Sign Up",
                fontWeight: FontWeight.w500,
                fontSize: 12,
                fontColor: Colors.blue,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
