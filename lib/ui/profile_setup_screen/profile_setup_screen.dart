import 'dart:developer';

import 'package:cure_near/widgets/elevated_button_widget.dart';
import 'package:cure_near/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

import '../../logic/profile_setup_screen/profile_setup_bloc.dart';
import '../../logic/profile_setup_screen/profile_setup_event.dart';
import '../../logic/profile_setup_screen/profile_setup_state.dart';
import '../../widgets/text_feild.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController genderTextController = TextEditingController();
  final TextEditingController dateOfBirthTextController = TextEditingController();
  final TextEditingController dateOfBirthTextControllerView = TextEditingController();

  @override
  void initState() {
    context.read<ProfileBloc>().add(UserCheckRequested());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        log('Listener triggered: $state');
        if (state is ProfileUpdated) {
          // Perform navigation here
          GoRouter.of(context).go('/main');
        }
      },
      builder: (context, state) {
        if (state is ProfileSuccess) {
          nameController.text = state.name;
          emailController.text = state.email;
        }
        return Scaffold(
          appBar: AppBar(
            title: TextView(
              text: 'Fill Your Profile',
              fontSize: 18.sp,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppTextField(
                    enabled: false,
                    hintText: 'Full Name',
                    controller: nameController,
                    prefixIcon: Icon(
                      Icons.person_2_outlined,
                      color: Colors.grey.shade700,
                    ),
                    keyboardType: TextInputType.name,
                    filled: true,
                    obscureText: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.sp),
                  AppTextField(
                    hintText: 'Email',
                    enabled: false,
                    controller: emailController,
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
                    hintText: 'Phone Number',
                    controller: phoneNumberController,
                    prefixIcon: Icon(
                      Icons.call_outlined,
                      color: Colors.grey.shade700,
                    ),
                    keyboardType: TextInputType.phone,
                    filled: true,
                    obscureText: false,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      if (value.length < 10) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.sp),
                  GestureDetector(
                    onTap: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDate != null) {
                        context.read<ProfileBloc>().add(ProfilePageRefresh());
                        dateOfBirthTextControllerView.text = selectedDate.toLocal().toString().split(' ')[0];
                        dateOfBirthTextController.text = selectedDate.toString();
                      }
                    },
                    child: InputDecorator(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8.0,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade200,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              8.0,
                            ),
                          ),
                          borderSide: BorderSide(
                            color: Colors.grey.shade400,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      child: TextView(
                        text: dateOfBirthTextControllerView.text != '' ? dateOfBirthTextControllerView.text : 'Date of Birth',
                      ),
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  GestureDetector(
                    onTap: () async {
                      final selectedValue = await showModalBottomSheet<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            // height: MediaQuery.sizeOf(context).height * 0.5,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 16.sp,
                                ),
                                Container(
                                  height: 6.sp,
                                  width: 50.sp,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade700,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        10.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                ListTile(
                                  title: const TextView(text: 'Male'),
                                  onTap: () {
                                    Navigator.pop(context, 'Male');
                                  },
                                ),
                                ListTile(
                                  title: const TextView(text: 'Female'),
                                  onTap: () {
                                    Navigator.pop(context, 'Female');
                                  },
                                ),
                                ListTile(
                                  title: const TextView(text: 'Other'),
                                  onTap: () {
                                    Navigator.pop(context, 'Other');
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );

                      if (selectedValue != null) {
                        context.read<ProfileBloc>().add(ProfilePageRefresh());
                        genderTextController.text = selectedValue;
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.grey.shade400,
                        ),
                        color: Colors.grey.shade200,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextView(
                            text: genderTextController.text != '' ? genderTextController.text : 'Gender',
                            fontColor: genderTextController.text != '' ? Colors.black : Colors.grey,
                          ),
                          const Icon(Icons.arrow_drop_down),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.sp),
                  (state is ProfileSubmitting)
                      ? const CupertinoActivityIndicator()
                      : ElevatedButtonWidget(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (phoneNumberController.text == '') {
                              Fluttertoast.showToast(msg: 'Phone Number is required!');
                              return;
                            }
                            if (dateOfBirthTextController.text == '') {
                              Fluttertoast.showToast(msg: 'Date of Birth is required!');
                              return;
                            }
                            if (genderTextController.text == '') {
                              Fluttertoast.showToast(msg: 'Gender is required!');
                              return;
                            }
                            context.read<ProfileBloc>().add(ProfileSubmitted(
                                email: emailController.text,
                                gender: genderTextController.text,
                                name: nameController.text,
                                phoneNumber: phoneNumberController.text,
                                dateOfBirth: DateTime.tryParse(dateOfBirthTextController.text)));
                          },
                          text: 'Save',
                        ),
                  if (state is ProfileFailure)
                    TextView(
                      text: state.errorMessage,
                      fontColor: Colors.red,
                      maxLines: 3,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
