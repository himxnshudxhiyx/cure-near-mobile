import 'package:cure_near/services/shared_preferences.dart';
import 'package:cure_near/widgets/custom_inkwell.dart';
import 'package:cure_near/widgets/text_widget.dart';
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextView(
              text: "Location",
              fontWeight: FontWeight.w400,
              fontColor: Colors.grey,
            ),
            BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is HomeLocationError) {}
              },
              builder: (context, state) {
                if (state is HomeLocationState) {
                  return TextView(text: '${state.place.street ?? '-'}, ${state.place.locality ?? '-'}');
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
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
          if (state is HomeError) {
            // Handle error state if needed, like showing a snackbar or dialog
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(content: Text(state.message)),
            // );
          }
        },
        builder: (context, state) {
          return Container();
          // if (state is HomeLocationState) {
          //   return Center(
          //     child: Text(
          //         'Current Location: ${state.place.street}, ${state.place.locality}, ${state.place.administrativeArea}, ${state.place.country}'),
          //   );
          // } else {
          //   return const Center(child: CircularProgressIndicator());
          // }
        },
      ),
    );
  }
}
