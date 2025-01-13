import 'package:cure_near/widgets/custom_app_bar.dart';
import 'package:cure_near/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Profile',
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              _profileDetails(context),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileDetails(context) {
    return Center(
      child: Container(
        color: Colors.grey.shade100,
        width: MediaQuery.sizeOf(context).width * 0.6,
        child: Column(
          children: [
            TextView(text: 'Name'),
            TextView(text: 'Number'),
            TextView(text: 'Email'),
          ],
        ),
      ),
    );
  }
}
