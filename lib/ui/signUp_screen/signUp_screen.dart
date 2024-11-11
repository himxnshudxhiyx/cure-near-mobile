import 'package:cure_near/widgets/elevated_button_widget.dart';
import 'package:cure_near/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../logic/signUp_screen/signUp_bloc.dart';
import '../../logic/signUp_screen/signUp_event.dart';
import '../../logic/signUp_screen/signUp_state.dart';
import '../../widgets/text_feild.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    if (kDebugMode) {
      _emailController.text = 'himanshu.44909@gmail.com';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('SignUp Successful')),
              );
            } else if (state is SignUpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('SignUp Failed: ${state.errorMessage}')),
              );
            }
          },
          child: BlocBuilder<SignUpBloc, SignUpState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _welcomeView(context),
                  AppTextField(
                    hintText: "Name",
                    controller: _nameController,
                    prefixIcon: Icon(
                      Icons.person_2_outlined,
                      color: Colors.grey.shade700,
                    ),
                    keyboardType: TextInputType.name,
                    filled: true,
                    // obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.sp),
                  AppTextField(
                    hintText: "Email",
                    controller: _emailController,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: Colors.grey.shade700,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    filled: true,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      // Regular expression for basic email validation
                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
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
                    prefixIcon: Icon(
                      Icons.lock_outline_rounded,
                      color: Colors.grey.shade700,
                    ),
                    suffixWidget: Icon(
                      Icons.remove_red_eye_rounded,
                      color: Colors.grey.shade700,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      // Check for minimum 8 characters
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      // Check for at least one uppercase letter
                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                        return 'Password must contain at least one uppercase letter';
                      }
                      // Check for at least one lowercase letter
                      if (!RegExp(r'[a-z]').hasMatch(value)) {
                        return 'Password must contain at least one lowercase letter';
                      }
                      // Check for at least one digit
                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                        return 'Password must contain at least one digit';
                      }
                      // Check for at least one special character
                      if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
                        return 'Password must contain at least one special character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30.sp),
                  (state is SignUpLoading)
                      ? const CupertinoActivityIndicator()
                      : ElevatedButtonWidget(
                          onPressed: () {
                            context.read<SignUpBloc>().add(
                                  SignUpSubmitted(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          },
                          text: 'Create Account',
                        ),
                  // if (state is SignUpLoading) const CupertinoActivityIndicator(),
                  _signInView(context),
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
            text: "Create Account",
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
          SizedBox(
            height: 6.sp,
          ),
          TextView(
            text: "We are here to help you!",
            fontWeight: FontWeight.w300,
            fontSize: 16,
            fontColor: Colors.grey.shade500,
          ),
          SizedBox(
            height: 20.sp,
          ),
        ],
      ),
    );
  }

  Widget _signInView(context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('SignUp Successful')),
          );
        } else if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('SignUp Failed: ${state.errorMessage}')),
          );
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              children: [
                SizedBox(
                  height: 30.sp,
                ),
                // const TextView(
                //   text: "Forgot password?",
                //   // fontWeight: FontWeight.w500,
                //   fontSize: 15,
                //   fontColor: Colors.blue,
                // ),
                // SizedBox(
                //   height: 16.sp,
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextView(
                      text: "Already have an account? ",
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                    InkWell(
                      onTap: () {
                        context.pop();
                      },
                      child: const TextView(
                        text: "Sign in",
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        fontColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
