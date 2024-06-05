import 'package:dri_learn/features/authentication/domain/model/user_entity.dart';
import 'package:dri_learn/features/provinceSelector/presentation/province_screen.dart';
import 'package:dri_learn/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dri_learn/features/onboarding/presentation/onboarding_screen.dart';

/// The route configuration.
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return ProvinceSelector();
        }),
    GoRoute(
      path: ScreenRoutes.onBoarding().route,
      builder: (BuildContext context, GoRouterState state) {
        return OnboardingScreen();
      },
    ),
    GoRoute(
      path: ScreenRoutes.provinceSelection().route,
      builder: (BuildContext context, GoRouterState state) {
        return ProvinceSelector();
      },
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
  String get route => "/onboarding";
}

class ProvinceSelection extends ScreenRoutes {
  @override
  String get route => "/provinceselection";
}
