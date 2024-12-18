import 'package:cure_near/ui/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/tab_bar_screen/tab_bar_bloc.dart';
import '../../logic/tab_bar_screen/tab_bar_event.dart';
import '../../logic/tab_bar_screen/tab_bar_state.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TabBarBloc>().add(TabChanged(0));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<TabBarBloc, TabBarState>(
        listener: (context, state) {
          // Handle any side effects here (like showing a message)
        },
        builder: (context, state) {
          if (state is TabBarChanged) {
            switch (state.index) {
              case 0:
                return const HomeScreen();
              case 1:
                return const SizedBox();
              case 2:
                return const SizedBox();
              default:
                return const SizedBox();
            }
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: BlocBuilder<TabBarBloc, TabBarState>(
        builder: (context, state) {
          int selectedIndex = 0;
          if (state is TabBarChanged) {
            selectedIndex = state.index;
          }
          return BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (int index) {
              context.read<TabBarBloc>().add(TabChanged(index));
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
