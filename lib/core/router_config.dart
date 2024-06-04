import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:me_pass_drive_test/features/onboarding/presentation/onboarding_screen.dart';

/// The route configuration.
final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return OnboardingScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: ScreenRoutes.onBoarding().route,
          builder: (BuildContext context, GoRouterState state) {
            return OnboardingScreen();
          },
        ),
        GoRoute(
          path: ScreenRoutes.provinceSelection().route,
          builder: (BuildContext context, GoRouterState state) {
            return OnboardingScreen();
          },
        ),
      ],
    ),
  ],
);

sealed class ScreenRoutes {
  const ScreenRoutes();
  String get route;
  factory ScreenRoutes.onBoarding() = Onboarding;
  factory ScreenRoutes.provinceSelection() = ProvinceSelection;
}

class Onboarding extends ScreenRoutes {
  @override
  String get route => "onboarding";
}

class ProvinceSelection extends ScreenRoutes {
  @override
  String get route => "provinceSelection";
}
