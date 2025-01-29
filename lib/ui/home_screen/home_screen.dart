import 'package:cure_near/services/shared_preferences.dart';
import 'package:cure_near/widgets/custom_colors.dart';
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
    context.read<HomeBloc>().add(GetHospitalCatEvent());
    context.read<HomeBloc>().add(GetNearbyHospitalEvent());
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
            // context.read<HomeBloc>().add(GetHospitalCatEvent());
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
              Row(
                children: [
                  Image.asset(
                    'assets/Icon_Location.png',
                    height: 15.sp,
                    width: 15.sp,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  BlocConsumer<HomeBloc, HomeState>(
                    listener: (context, state) {
                      if (state is HomeLocationError) {}
                    },
                    builder: (context, state) {
                      if (state is HomeUpdatedState) {
                        String? savedAddress = SharedPrefsHelper().getString('savedAddress');
                        final currentAddress = '${state.place?.street ?? '-'}, ${state.place?.locality ?? '-'}';

                        if (savedAddress.toString().contains('null')) {
                          savedAddress = '-';
                        }
                        if (state.place != null) {
                          SharedPrefsHelper().setString('savedAddress', currentAddress);
                        }

                        return TextView(
                          text: (state.locationError != null && savedAddress?.isNotEmpty == true) ? savedAddress! : currentAddress,
                          fontSize: 15,
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {}
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  SizedBox(
                    height: 16.h,
                  ),
                  Stack(
                    children: [
                      Image.asset(
                        'assets/Image_Banner.png',
                        width: MediaQuery.sizeOf(context).width,
                        fit: BoxFit.fitWidth,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        padding: EdgeInsets.only(left: 15.w, top: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextView(
                              text: 'Looking for\nSpecialist Doctors?',
                              fontColor: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 16.h,
                            ),
                            TextView(
                              text: 'Schedule an appointment with our top doctors.',
                              maxLines: 2,
                              fontColor: Colors.white,
                              fontSize: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextView(
                        text: 'Categories',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      TextView(
                        text: 'See All',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  BlocConsumer<HomeBloc, HomeState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is HomeUpdatedState) {
                        return (state.hospitalCategories.isEmpty)
                            ? SizedBox()
                            : GridView.builder(
                                shrinkWrap: true,
                                itemCount: 6,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisExtent: 40.h,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 6.w,
                                  childAspectRatio: 1, // Keeps square aspect ratio
                                ),
                                itemBuilder: (context, index) {
                                  final category = state.hospitalCategories[index];
                                  return Container(
                                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1, color: CustomColors.containerBorderColor),
                                      borderRadius: BorderRadius.circular(8.r),
                                      color: Colors.teal.shade500,
                                    ),
                                    child: Center(
                                      child: TextView(
                                        text: category.name ?? '',
                                        fontWeight: FontWeight.w500,
                                        maxLines: 2,
                                        fontSize: 14,
                                        fontColor: Colors.white,
                                      ),
                                    ),
                                  );
                                },
                              );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextView(
                        text: 'Nearby Hospitals',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      TextView(
                        text: 'See All',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  BlocConsumer<HomeBloc, HomeState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is HomeUpdatedState) {
                        return (state.nearByHospitals.isEmpty)
                            ? SizedBox()
                            : Container(
                                height: 140.h,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: state.nearByHospitals.length,
                                  physics: AlwaysScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  padding: EdgeInsets.zero,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      width: 10.w,
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    final category = state.nearByHospitals[index];
                                    return Container(
                                      width: MediaQuery.sizeOf(context).width * 0.8,
                                      padding: EdgeInsets.all(10.sp),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1, color: CustomColors.containerBorderColor),
                                        borderRadius: BorderRadius.circular(8.r),
                                        color: CustomColors.appMainColor,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: TextView(
                                              text: category.name ?? '',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20,
                                              fontColor: CustomColors.fontColor,
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          ...[
                                            {"label": "Location", "value": category.address},
                                            {"label": "Services", "value": category.services?.join(', ')},
                                            {"label": "Categories", "value": category.category?.join(', ')},
                                            {"label": "Phone", "value": category.phone}
                                          ].map((item) {
                                            return Padding(
                                              padding: EdgeInsets.only(bottom: 6.h),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: TextView(
                                                      text: item["label"]!,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14,
                                                      fontColor: CustomColors.fontColor,
                                                    ),
                                                  ),
                                                  SizedBox(width: 20.w),
                                                  Expanded(
                                                    child: TextView(
                                                      text: item["value"] ?? '',
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14,
                                                      fontColor: CustomColors.fontColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
