import 'package:ontario_g1_test_2024/features/authentication/domain/model/user_entity.dart';
import 'package:ontario_g1_test_2024/features/authentication/presentation/authentication_bloc.dart';
import 'package:ontario_g1_test_2024/features/authentication/presentation/authentication_state.dart';
import 'package:ontario_g1_test_2024/features/history/presentation/history_screen.dart';
import 'package:ontario_g1_test_2024/features/home/home_page.dart';
import 'package:ontario_g1_test_2024/features/provinceSelector/presentation/province_screen.dart';
import 'package:ontario_g1_test_2024/features/testOptions/learn_test_options.dart';
import 'package:ontario_g1_test_2024/features/testOptions/mock_test_options.dart';
import 'package:ontario_g1_test_2024/features/tests/description/presentation/test_description.dart';
import 'package:ontario_g1_test_2024/features/tests/testComplete/presentation/test_complete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ontario_g1_test_2024/features/onboarding/presentation/onboarding_screen.dart';

import '../features/tests/mock/presentation/mock_test_screen.dart';

/// The route configuration.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingScreen();
      },
      redirect: (context, state) {
        if (context.read<AuthBloc>().state is Done &&
            (context.read<AuthBloc>().state as Done).user != null) {
          return ScreenRoutes.homePage().route;
        }
        return null;
      },
    ),
    GoRoute(
      path: ScreenRoutes.onBoarding().route,
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingScreen();
      },
    ),
    GoRoute(
      path: ScreenRoutes.provinceSelection().route,
      builder: (BuildContext context, GoRouterState state) {
        return const ProvinceSelector();
      },
    ),
    GoRoute(
      path: ScreenRoutes.homePage().route,
      builder: (BuildContext context, GoRouterState state) {
        User? user = (context.read<AuthBloc>().state as Done?)?.user;
        if (user != null) {
          return HomePageScreen(user: user);
        } else {
          return const OnboardingScreen();
        }
      },
    ),
    GoRoute(
      path: ScreenRoutes.mockTestOptions().route,
      builder: (BuildContext context, GoRouterState state) {
        return MockTestOptionsScreen(
          user: state.extra as User,
        );
      },
    ),
    GoRoute(
      path: ScreenRoutes.learnTestOptions().route,
      builder: (BuildContext context, GoRouterState state) {
        return LearnTestOptions(
          user: state.extra as User,
        );
      },
    ),
    GoRoute(
      path: ScreenRoutes.testDescription().route,
      builder: (BuildContext context, GoRouterState state) {
        return const TestDescripScreen();
      },
    ),
    GoRoute(
      path: ScreenRoutes.mockTest().route,
      builder: (BuildContext context, GoRouterState state) {
        return MockTestScreen();
      },
    ),
    GoRoute(
      path: ScreenRoutes.testComplete().route,
      builder: (BuildContext context, GoRouterState state) {
        return const TestComplete();
      },
    ),
    GoRoute(
      path: ScreenRoutes.testHistory().route,
      builder: (BuildContext context, GoRouterState state) {
        return HistoryScreen(user: state.extra as User);
      },
    ),
  ],
);

sealed class ScreenRoutes {
  ScreenRoutes();
  String get route;
  factory ScreenRoutes.onBoarding() = Onboarding;
  factory ScreenRoutes.provinceSelection() = ProvinceSelection;
  factory ScreenRoutes.homePage() = HomePage;
  factory ScreenRoutes.mockTestOptions() = MockTestOption;
  factory ScreenRoutes.learnTestOptions() = LearnTestOption;
  factory ScreenRoutes.testDescription() = TestDescription;
  factory ScreenRoutes.mockTest() = MockTestScreenRoute;
  factory ScreenRoutes.testComplete() = TestCompleteRoute;
  factory ScreenRoutes.testHistory() = TestHistoryRoute;

  String home = "/";
}

class Onboarding extends ScreenRoutes {
  @override
  String get route => "/onboarding";
}

class ProvinceSelection extends ScreenRoutes {
  @override
  String get route => "/provinceselection";
}

class HomePage extends ScreenRoutes {
  @override
  String get route => "/homepage";
}

class MockTestOption extends ScreenRoutes {
  @override
  String get route => "/mocktestoptions";
}

class LearnTestOption extends ScreenRoutes {
  @override
  String get route => "/learntestoptions";
}

class TestDescription extends ScreenRoutes {
  @override
  String get route => "/testdescriptions";
}

class MockTestScreenRoute extends ScreenRoutes {
  @override
  String get route => "/mocktest";
}

class TestCompleteRoute extends ScreenRoutes {
  @override
  String get route => "/testcomplete";
}

class TestHistoryRoute extends ScreenRoutes {
  @override
  String get route => "/testhistory";
}
