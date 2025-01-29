import 'package:cure_near/logic/profile_screen/profile_screen_state.dart';
import 'package:cure_near/widgets/custom_app_bar.dart';
import 'package:cure_near/widgets/custom_inkwell.dart';
import 'package:cure_near/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../logic/profile_screen/profile_screen_bloc.dart';
import '../../services/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, dynamic>> profileItems = [
    {'id': 0, 'title': 'Edit Profile', 'icon': CupertinoIcons.person},
    {'id': 1, 'title': 'Favourite', 'icon': CupertinoIcons.heart},
    {'id': 2, 'title': 'Notifications', 'icon': CupertinoIcons.bell},
    {'id': 3, 'title': 'Help and Support', 'icon': CupertinoIcons.question_circle},
    {'id': 4, 'title': 'Terms and Conditions', 'icon': CupertinoIcons.lock_shield},
    {'id': 5, 'title': 'Privacy Policy', 'icon': CupertinoIcons.lock},
    {'id': 6, 'title': 'Logout', 'icon': Icons.logout},
  ];

  @override
  void initState() {
    super.initState();
    // context.read<ProfileScreenBloc>().add(GetProfileDetailsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        centerTitle: true,
      ),
      body: BlocConsumer<ProfileScreenBloc, ProfileScreenState>(
        listener: (context, state) {
          if (state is ProfileErrorState) {
            // Show error message using SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is ProfileLoadedState) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    _profileDetails(context, state.name, state.email, state.phone),
                    SizedBox(
                      height: 10.h,
                    ),
                    _iconViews(context),
                  ],
                ),
              ),
            );
          } else if (state is ProfileErrorState) {
            return Center(
              child: Text(
                'Failed to load profile details.',
                style: TextStyle(color: Colors.red, fontSize: 16.sp),
              ),
            );
          }
          return const SizedBox.shrink(); // Fallback for unknown states
        },
      ),
    );
  }

  Widget _profileDetails(BuildContext context, String name, String email, String phone) {
    return Center(
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(width: 2, color: Colors.grey.shade300),
          borderRadius: BorderRadius.all(
            Radius.circular(5.r),
          ),
        ),
        padding: EdgeInsets.all(10.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: 'Name: $name',
              fontSize: 12,
            ),
            TextView(
              text: 'Number: $phone',
              fontSize: 12,
            ),
            TextView(
              text: 'Email: $email',
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconViews(context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      itemCount: profileItems.length,
      shrinkWrap: true,
      itemBuilder: (c, index) {
        return _itemView(c, index);
      },
      separatorBuilder: (cx, i) {
        return Container(
          height: 1,
          color: Colors.grey.shade200,
        );
      },
    );
  }

  Widget _itemView(context, index) {
    return CustomInkwell(
      onTap: () {
        if (profileItems[index]['id'] == 6) {
          SharedPrefsHelper().clearAll();
          GoRouter.of(context).pushReplacement('/login');
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        width: MediaQuery.sizeOf(context).width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 10.w,
              children: [
                Icon(
                  profileItems[index]['icon'],
                  size: 24.sp,
                  color: Colors.grey.shade700,
                ),
                TextView(
                  text: profileItems[index]['title'],
                  fontSize: 16,
                  fontColor: Colors.grey.shade500,
                ),
              ],
            ),
            (index == profileItems.length - 1)
                ? SizedBox.shrink()
                : Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.sp,
                    color: Colors.grey,
                  ),
          ],
        ),
      ),
    );
  }
}
