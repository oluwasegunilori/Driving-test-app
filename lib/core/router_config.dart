import 'package:dri_learn/features/authentication/domain/model/user_entity.dart';
import 'package:dri_learn/features/authentication/presentation/authentication_bloc.dart';
import 'package:dri_learn/features/authentication/presentation/authentication_state.dart';
import 'package:dri_learn/features/provinceSelector/presentation/province_screen.dart';
import 'package:dri_learn/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dri_learn/features/onboarding/presentation/onboarding_screen.dart';

/// The route configuration.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return OnboardingScreen();
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
        return OnboardingScreen();
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
        return MyHomePage();
      },
    ),
  ],
);

sealed class ScreenRoutes {
  const ScreenRoutes();
  String get route;
  factory ScreenRoutes.onBoarding() = Onboarding;
  factory ScreenRoutes.provinceSelection() = ProvinceSelection;
  factory ScreenRoutes.homePage() = HomePage;
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
