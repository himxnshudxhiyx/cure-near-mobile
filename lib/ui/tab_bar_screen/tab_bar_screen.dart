import 'package:cure_near/logic/profile_screen/profile_screen_bloc.dart';
import 'package:cure_near/ui/booking_screen/booking_screen.dart';
import 'package:cure_near/ui/home_screen/home_screen.dart';
import 'package:cure_near/ui/profile_screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../logic/profile_screen/profile_screen_event.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  PersistentTabController _controller = PersistentTabController();

  ScrollController _scrollController1 = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  ScrollController _scrollController3 = ScrollController();

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      BookingScreen(),
      ProfileScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        // scrollController: _scrollController1,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/home",
          routes: {
            "/home": (final context) => const HomeScreen(),
            "/bookings": (final context) => const BookingScreen(),
            "/profile": (final context) => const ProfileScreen(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.calendar),
        title: ("Bookings"),
        activeColorPrimary: CupertinoColors.activeGreen,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        // scrollController: _scrollController2,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/home",
          routes: {
            "/home": (final context) => const HomeScreen(),
            "/bookings": (final context) => const BookingScreen(),
            "/profile": (final context) => const ProfileScreen(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        title: ("Profile"),
        activeColorPrimary: CupertinoColors.activeOrange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
        // scrollController: _scrollController3,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: "/home",
          routes: {
            "/home": (final context) => const HomeScreen(),
            "/bookings": (final context) => const BookingScreen(),
            "/profile": (final context) => const ProfileScreen(),
          },
        ),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    // context.read<TabBarBloc>().add(TabChanged(0));
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
      // padding: const EdgeInsets.only(top: 8),
      // backgroundColor: Colors.grey.shade900,
      isVisible: true,
      onItemSelected: (value) {
        if (value == 2) {
          context.read<ProfileScreenBloc>().add(GetProfileDetailsEvent());
        }
      },
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 200),
          screenTransitionAnimationType: ScreenTransitionAnimationType.fadeIn,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: kBottomNavigationBarHeight,
      navBarStyle: NavBarStyle.style1,
      decoration: NavBarDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: Colors.grey.shade100,
          ),
        ),
      ),
    );
    // return Scaffold(
    //   // body: BlocConsumer<TabBarBloc, TabBarState>(
    //   //   listener: (context, state) {
    //   //     // Handle any side effects here (like showing a message)
    //   //   },
    //   //   builder: (context, state) {
    //   //     if (state is TabBarChanged) {
    //   //       switch (state.index) {
    //   //         case 0:
    //   //           return const HomeScreen();
    //   //         case 1:
    //   //           return const SizedBox();
    //   //         case 2:
    //   //           return const SizedBox();
    //   //         default:
    //   //           return const SizedBox();
    //   //       }
    //   //     }
    //   //     return const SizedBox();
    //   //   },
    //   // ),
    //   // bottomNavigationBar: BlocBuilder<TabBarBloc, TabBarState>(
    //   //   builder: (context, state) {
    //   //     int selectedIndex = 0;
    //   //     if (state is TabBarChanged) {
    //   //       selectedIndex = state.index;
    //   //     }
    //   //     // return BottomNavigationBar(
    //   //     //   currentIndex: selectedIndex,
    //   //     //   onTap: (int index) {
    //   //     //     context.read<TabBarBloc>().add(TabChanged(index));
    //   //     //   },
    //   //     //   items: const <BottomNavigationBarItem>[
    //   //     //     BottomNavigationBarItem(
    //   //     //       icon: Icon(
    //   //     //         Icons.home,
    //   //     //       ),
    //   //     //       label: 'Home',
    //   //     //     ),
    //   //     //     BottomNavigationBarItem(
    //   //     //       icon: Icon(
    //   //     //         Icons.calendar_month,
    //   //     //       ),
    //   //     //       label: 'Bookings',
    //   //     //     ),
    //   //     //     BottomNavigationBarItem(
    //   //     //       icon: Icon(
    //   //     //         Icons.person,
    //   //     //       ),
    //   //     //       label: 'Profile',
    //   //     //     ),
    //   //     //   ],
    //   //     // );
    //   //   },
    //   // ),
    // );
  }
}
