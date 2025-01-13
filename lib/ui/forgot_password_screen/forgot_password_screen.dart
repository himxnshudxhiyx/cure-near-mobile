import 'package:cure_near/services/logger_service.dart';
import 'package:cure_near/widgets/custom_inkwell.dart';
import 'package:cure_near/widgets/text_feild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../logic/forgot_password_screen/forgot_password_bloc.dart';
import '../../logic/forgot_password_screen/forgot_password_event.dart';
import '../../logic/forgot_password_screen/forgot_password_state.dart';
import '../../widgets/elevated_button_widget.dart';
import '../../widgets/text_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is PasswordChangedState) {
              GoRouter.of(context).pop(true);
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Text(state.message)),
              // );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: kToolbarHeight + 50),
                      child: Image.asset(
                        'assets/Ic_Logo.png',
                        // height: 100.h,
                        // width: 100.w,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const TextView(
                    text: "Cure Near",
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const Divider(),
                  if (state is ForgotPasswordInitialState || state is EmailSubmittingState)
                    _emailInputView(context, state is EmailSubmittingState)
                  else if (state is EmailSubmittedState || state is OtpSubmittingState)
                    _otpInputView(context, state is OtpSubmittingState)
                  else if (state is OtpVerifiedState || state is PasswordChangingState)
                    _changePasswordView(context, state is PasswordChangingState)
                  else if (state is PasswordChangedState)
                    const Center(child: Text("Password successfully changed!"))
                  else
                    const SizedBox.shrink(), // Fallback view
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _emailInputView(BuildContext context, bool isSubmitting) {
    TextEditingController emailController = TextEditingController();
    FocusNode emailFocusNode = FocusNode();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextView(
              text: "Forgot Password?",
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextView(
            text: "Enter your Email, we will send you a verification code.",
            fontWeight: FontWeight.w300,
            fontSize: 16,
            maxLines: 3,
            textAlign: TextAlign.center,
            fontColor: Colors.grey.shade500,
          ),
          SizedBox(
            height: 10.h,
          ),
          Form(
            key: formKey,
            child: AppTextField(
              hintText: "Email",
              controller: emailController,
              focusNode: emailFocusNode,
              prefixIcon: Icon(
                Icons.email_outlined,
                color: Colors.grey.shade700,
              ),
              keyboardType: TextInputType.emailAddress,
              filled: true,
              // obscureText: false,
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
          ),
          SizedBox(height: 20.h),
          isSubmitting
              ? const CupertinoActivityIndicator()
              : ElevatedButtonWidget(
                  text: isSubmitting ? "" : "Send Code",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<ForgotPasswordBloc>().add(
                            EnterEmailEvent(emailController.text),
                          );
                    }
                  },
                  // bgColor: Colors.grey,
                  textColor: Colors.white,
                ),
        ],
      ),
    );
  }

  Widget _otpInputView(BuildContext context, bool isSubmitting) {
    final otpController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextView(
              text: "Verify Code",
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          TextView(
            text: "Enter the the code we just sent you on your registered Email",
            fontWeight: FontWeight.w300,
            fontSize: 16,
            maxLines: 3,
            textAlign: TextAlign.center,
            fontColor: Colors.grey.shade500,
          ),
          SizedBox(
            height: 10.h,
          ),
          Form(
            key: formKey,
            child: OtpTextField(
              numberOfFields: 5,
              focusedBorderColor: Theme.of(context).primaryColor,
              filled: true,
              fillColor: Colors.grey.shade100,
              // borderColor: Color(0xFF512DA8),
              keyboardType: TextInputType.number,
              borderRadius: BorderRadius.circular(10.r),
              fieldWidth: MediaQuery.sizeOf(context).width * 0.13,
              autoFocus: false,
              showFieldAsBox: true,
              styles: [],
              onCodeChanged: (String code) {
                //do nothing here
              },
              onSubmit: (String verificationCode) {
                otpController.text = verificationCode;
                Logger.logObject(object: 'OTP Entered ${otpController.text}');
                context.read<ForgotPasswordBloc>().add(
                      VerifyOtpEvent(otpController.text),
                    );
              }, // end onSubmit
            ),
          ),
          SizedBox(height: 20.h),
          isSubmitting
              ? const CupertinoActivityIndicator()
              : ElevatedButtonWidget(
                  text: isSubmitting ? "" : "Verify",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      context.read<ForgotPasswordBloc>().add(
                            VerifyOtpEvent(otpController.text),
                          );
                    }
                  },
                  // bgColor: Colors.grey,
                  textColor: Colors.white,
                ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextView(
                text: 'Didn\'t get the Code? ',
              ),
              CustomInkwell(
                onTap: () {},
                child: TextView(
                  text: 'Resend',
                  fontColor: Colors.blue,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _changePasswordView(BuildContext context, bool isSubmitting) {
    TextEditingController newPasswordController = TextEditingController();
    FocusNode newPasswordFocusNode = FocusNode();
    TextEditingController confirmPasswordController = TextEditingController();
    FocusNode confirmPasswordFocusNode = FocusNode();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextView(
                text: "Create New Password",
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextView(
              text: "Your new password must be different form previously used password",
              fontWeight: FontWeight.w300,
              fontSize: 16,
              maxLines: 3,
              textAlign: TextAlign.center,
              fontColor: Colors.grey.shade500,
            ),
            SizedBox(
              height: 10.h,
            ),
            AppTextField(
              hintText: "Password",
              controller: newPasswordController,
              obscureText: true,
              filled: true,
              focusNode: newPasswordFocusNode,
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
            SizedBox(height: 10.h),
            AppTextField(
              hintText: "Confirm Password",
              controller: confirmPasswordController,
              obscureText: true,
              filled: true,
              focusNode: confirmPasswordFocusNode,
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
            SizedBox(height: 20.h),
            isSubmitting
                ? CupertinoActivityIndicator()
                : ElevatedButtonWidget(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<ForgotPasswordBloc>().add(
                              ChangePasswordEvent(
                                newPasswordController.text,
                                confirmPasswordController.text,
                              ),
                            );
                      }
                    },
                    text: "Reset Password",
                  ),
          ],
        ),
      ),
    );
  }
}
