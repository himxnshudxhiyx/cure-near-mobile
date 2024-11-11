import 'package:cure_near/ui/login_screen/login_screen.dart';
import 'package:cure_near/ui/on_boarding_screen/on_boarding_screen.dart';
import 'package:cure_near/ui/signUp_screen/signUp_screen.dart';
import 'package:go_router/go_router.dart';

import '../ui/splash_screen/splash_screen.dart';
import 'custom_transition.dart';

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    // GoRoute(
    //   path: '/userPost',
    //   builder: (context, state) => const UserPostScreen(),
    // ),
    // GoRoute(
    //   path: '/userPost/:title',
    //   pageBuilder: (context, state) {
    //     final title = state.pathParameters['title']; // Accessing the parameter
    //     return CustomTransitionPage(
    //       key: state.pageKey,
    //       child: UserPostScreen(title: title),
    //       transitionsBuilder: commonTransition,
    //     );
    //   },
    // ),
    GoRoute(
      path: '/',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const SplashScreen(),
            transitionsBuilder: commonTransition,
          );
        },
    ),
    GoRoute(
      path: '/onBoarding',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const OnBoardingScreen(),
            transitionsBuilder: commonTransition,
          );
        },
    ),
    GoRoute(
      path: '/login',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const LoginScreen(),
            transitionsBuilder: commonTransition,
          );
        },
    ),
    GoRoute(
      path: '/signUp',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const SignUpScreen(),
            transitionsBuilder: commonTransition,
          );
        },
    ),
  ],
);
