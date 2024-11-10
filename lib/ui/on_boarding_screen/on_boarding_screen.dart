import 'package:cure_near/widgets/elevated_button_widget.dart';
import 'package:cure_near/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../logic/on_boarding_screen/onboarding_bloc.dart';
import '../../logic/on_boarding_screen/onboarding_event.dart';
import '../../logic/on_boarding_screen/onboarding_state.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: Scaffold(
        body: BlocConsumer<OnboardingBloc, OnboardingState>(
          listener: (context, state) {
            if (state is OnboardingComplete) {
              context.go('/login');
            }
          },
          builder: (context, state) {
            if (state is OnboardingInitial) {
              return SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          if (index != state.currentPage) {
                            context.read<OnboardingBloc>().add(index > state.currentPage ? NextPageEvent() : PreviousPageEvent());
                          }
                        },
                        children: [
                          _buildPage("Find Nearby Hospitals", "Discover the best hospitals close to your location, with a list of trusted healthcare providers for any medical need.",
                              "assets/Icon_Onboarding.png"),
                          _buildPage("Book Appointments Easily", "Schedule appointments at hospitals quickly and conveniently without long waits, anytime, anywhere.",
                              "assets/Icon_Onboarding_1.png"),
                          _buildPage("Manage Your Health Efficiently", "Keep track of your health records, appointments, and reminders in one simple, user-friendly app.",
                              "assets/Icon_Onboarding_2.png"),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.sp),
                    _buildIndicator(),
                    SizedBox(height: 16.sp),
                    ElevatedButtonWidget(
                      text: state.currentPage < 2 ? "Next" : "Finish",
                      onPressed: () {
                        if (state.currentPage < 2) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          context.read<OnboardingBloc>().add(NextPageEvent());
                        } else {
                          context.read<OnboardingBloc>().add(CompleteOnboardingEvent());
                        }
                      },
                    ),
                    SizedBox(height: 16.sp),
                    Padding(
                      padding: EdgeInsets.only(bottom: 18.sp),
                      child: GestureDetector(
                        child: TextView(text: 'Skip', fontSize: 12.sp,),
                        onTap: () {
                          context.read<OnboardingBloc>().add(CompleteOnboardingEvent());
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CupertinoActivityIndicator());
          },
        ),
        // bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  Widget _buildPage(String title, String description, String image) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            image,
            width: MediaQuery.sizeOf(context).width,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(height: 16.sp),
          TextView(
            text: title,
            maxLines: 5,
          ),
          SizedBox(height: 16.sp),
          TextView(
            text: description,
            maxLines: 5,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
            fontColor: Colors.grey.shade500,
          ),
        ],
      );
    });
  }

  Widget _buildIndicator() {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is OnboardingInitial) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                height: 8.0,
                width: state.currentPage == index ? 25.sp : 8.sp,
                decoration: BoxDecoration(
                  color: state.currentPage == index ? Theme.of(context).primaryColor : Colors.grey,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  if (state is OnboardingInitial && state.currentPage > 0) {
                    context.read<OnboardingBloc>().add(PreviousPageEvent());
                  }
                },
                child: const Text("Previous"),
              ),
              TextButton(
                onPressed: () {
                  if (state is OnboardingInitial && state.currentPage < 2) {
                    context.read<OnboardingBloc>().add(NextPageEvent());
                  } else {
                    context.read<OnboardingBloc>().add(CompleteOnboardingEvent());
                  }
                },
                child: Text(state is OnboardingInitial && state.currentPage < 2 ? "Next" : "Finish"),
              ),
            ],
          ),
        );
      },
    );
  }
}
