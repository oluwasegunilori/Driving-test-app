// onboarding_screen.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:me_pass_drive_test/core/button_styles.dart';
import 'onboarding_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingScreen extends StatelessWidget {
  final List<String> onboardingPages = [
    'assets/images/onboard_img.jpeg',
    'assets/images/onboard_img.jpeg',
  ];

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
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
                          Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "DriLearn",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 45,
                                    ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Icon(
                                Icons.car_crash_rounded,
                                color: Colors.white,
                                size: 40,
                              )
                            ],
                          ))
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        if (page == 0) ...[
          Text(
            "Welcome to DriLearn!",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
              "Ace your driving test with our practice tests and lessons. Learn at your own pace and track your progress. Let's get started!",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.normal, fontSize: 13)),
          const Spacer(),
          ElevatedButton(
              onPressed: () => {onButtonClicked()},
              style: primaryRaisedButtonStyle(context),
              child: const Text("Get Started")),
          const SizedBox(
            height: 30,
          ),
        ] else
          ...[]
      ],
    );
  }
}
