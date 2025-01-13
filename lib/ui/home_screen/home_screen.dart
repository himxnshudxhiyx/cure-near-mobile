import 'package:cure_near/services/shared_preferences.dart';
import 'package:cure_near/widgets/custom_inkwell.dart';
import 'package:cure_near/widgets/text_feild.dart';
import 'package:cure_near/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../logic/home_screen/home_bloc.dart';
import '../../logic/home_screen/home_event.dart';
import '../../logic/home_screen/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0.0,
        title: CustomInkwell(
          onTap: () {
            context.read<HomeBloc>().add(GetLocationEvent());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView(
                text: "Location",
                fontWeight: FontWeight.w400,
                fontColor: Colors.grey,
                fontSize: 14,
              ),
              BlocConsumer<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state is HomeLocationError) {}
                },
                builder: (context, state) {
                  if (state is HomeLocationState) {
                    SharedPrefsHelper().setString('savedAddress', ' ${state.place.street}, ${state.place.locality}');
                    return TextView(
                      text: '${state.place.street ?? '-'}, ${state.place.locality ?? '-'}',
                      fontSize: 15,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
        centerTitle: false,
        // backgroundColor: Colors.blueAccent,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: CustomInkwell(
              onTap: () {
                SharedPrefsHelper().clearAll();
                GoRouter.of(context).push('/login');
              },
              child: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {}
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Column(
              children: [
                CustomInkwell(
                  onTap: () {
                    GoRouter.of(context).push('/search');
                  },
                  child: AppTextField(
                    controller: _searchTextController,
                    enabled: false,
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    borderColor: Colors.transparent,
                    hintText: "Search Doctor, Hospital, Medicine",
                    prefixIcon: Icon(CupertinoIcons.search),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
