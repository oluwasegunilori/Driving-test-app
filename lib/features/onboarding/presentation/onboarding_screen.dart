// onboarding_screen.dart

// ignore_for_file: invalid_use_of_protected_member

import 'package:dri_learn/core/router_config.dart';
import 'package:dri_learn/features/authentication/presentation/authentication_bloc.dart';
import 'package:dri_learn/features/authentication/presentation/authentication_event.dart';
import 'package:dri_learn/features/authentication/presentation/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:dri_learn/animation/animation_utils.dart';
import 'package:dri_learn/core/button_styles.dart';
import 'package:dri_learn/core/spaces.dart';
import 'package:dri_learn/core/text_style.dart';
import '../../../utils/onboarding_utils.dart';
import 'onboarding_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';
import '/core/di/injection_container.dart' as di;

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl.get<OnboardingBloc>(),
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<OnboardingBloc>(context);
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: PageView.builder(
                    controller: PageController(
                        initialPage: (state is OnboardingInitial)
                            ? state.currentPage
                            : 0),
                    onPageChanged: (index) {
                      // No action needed as BLoC handles state
                    },
                    itemCount: onboardingPages.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          Card(
                            margin: const EdgeInsets.all(0),
                            shadowColor: Colors.white,
                            elevation: 20,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Adjust the border radius as needed
                              child: Image.asset(
                                onboardingPages[index],
                                fit: BoxFit
                                    .cover, // This makes the image cover the entire area
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          Center(child: titleAndIcon(context))
                        ],
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: state is OnboardingInitial
                        ? bottomPageOnboarding(context,
                            page: state.currentPage,
                            onButtonClicked: () =>
                                {bloc.onEvent(NextPageEvent())})
                        : const Center(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget bottomPageOnboarding(BuildContext context,
      {required int page, required VoidCallback onButtonClicked}) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Done) {
          context.go(ScreenRoutes.provinceSelection().route, extra: state.user);
        } else if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.exception.message),
            ),
          );
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is Done) {
            return Center(
              child: Text(state.user!.email),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                if (page == 0) ...[
                  Text(
                    "Welcome to DriLearn!",
                    style: titleMedium(context,
                        size: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                      "Ace your driving test with our practice tests and lessons. Learn at your own pace and track your progress. Let's get started!",
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.normal, fontSize: 13)),
                  const Spacer(),
                  primaryButton(
                      context: context,
                      text: "Get Started",
                      onClick: () {
                        onButtonClicked();
                      }),
                  const SizedBox(
                    height: 30,
                  ),
                ] else ...[
                  Expanded(
                    child: futureWidget(
                        delayDuration: const Duration(milliseconds: 300),
                        animationDuration: const Duration(milliseconds: 300),
                        child: () {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Expanded(
                                        child: Divider(
                                      thickness: 2,
                                      color: Colors.black,
                                    )),
                                    horizontalSpace(10),
                                    Text(
                                      "Sign in with",
                                      style: titleMedium(
                                        context,
                                      ),
                                    ),
                                    horizontalSpace(10),
                                    const Expanded(
                                        child: Divider(
                                      thickness: 2,
                                      color: Colors.black,
                                    ))
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: socialMediaButton(
                                            context: context,
                                            text: "Google",
                                            icon: MdiIcons.google,
                                            onClick: () {
                                              authBloc
                                                  .add(GoogleSignInRequested());
                                            })),
                                    horizontalSpace(20),
                                    Expanded(
                                      child: socialMediaButton(
                                          context: context,
                                          text: "Apple",
                                          icon: MdiIcons.apple,
                                          onClick: () {}),
                                    ),
                                  ],
                                ),
                                if (state is Loading) ...[
                                  const LinearProgressIndicator(),
                                ],
                                TextButton(
                                    onPressed: () {
                                      context.go(
                                          ScreenRoutes.provinceSelection()
                                              .route);
                                    },
                                    child: Text(
                                      "Skip",
                                      style: titleMedium(context),
                                    ))
                              ],
                            ),
                          );
                        }),
                  ),
                ]
              ],
            );
          }
        },
      ),
    );
  }
}
