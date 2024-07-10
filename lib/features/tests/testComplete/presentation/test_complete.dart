import 'package:dri_learn/core/button_styles.dart';
import 'package:dri_learn/core/router_config.dart';
import 'package:dri_learn/core/spaces.dart';
import 'package:dri_learn/core/text_style.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_bloc.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_event.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '/core/di/injection_container.dart' as di;

class TestComplete extends StatelessWidget {
  const TestComplete({super.key});

  @override
  Widget build(BuildContext context) {
    final double imageHeight = MediaQuery.of(context).size.height * 0.25;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: imageHeight,
                child: Stack(
                  children: [
                    Card(
                      margin: const EdgeInsets.all(0),
                      shadowColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            15.0), // Adjust the border radius as needed
                        child: Image.asset(
                          "assets/images/onboard_img.jpeg",
                          fit: BoxFit
                              .cover, // This makes the image cover the entire area
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    Positioned(
                        bottom: 15,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Row(
                            children: [
                              Icon(
                                MdiIcons.car,
                                color: Theme.of(context).colorScheme.primary,
                                size: 36,
                              ),
                              horizontalSpace(10),
                              Text(
                                'Mock Test',
                                style: titleMedium(context)
                                    .copyWith(color: Colors.white),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      height: imageHeight,
                      child: Image.asset("assets/images/trophy.png")),
                  verticalSpace(20),
                  Text(
                    "You Passed!",
                    style: titleMedium(context)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  verticalSpace(10),
                  Text(
                    "Congratulations! You passed the test! Keep up the great work you're one step closer to acing your driving test!",
                    textAlign: TextAlign.center,
                    style: bodySmall(context),
                  ),
                  verticalSpace(20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          BlocBuilder<MockTestBloc, MockTestState>(
                            builder: (context, state) {
                              return Text(
                                getScore(state),
                                style: titleMedium(context)
                                    .copyWith(color: Colors.white),
                              );
                            },
                          ),
                          verticalSpace(10),
                          primaryButton(
                              context: context,
                              text: "   View Details    ",
                              onClick: () {
                                BlocProvider.of<MockTestBloc>(context)
                                    .add(SetViewModeEvent());
                                context.pop();
                              }),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            context.go(ScreenRoutes.homePage().route);
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.4)),
                              overlayColor:
                                  const WidgetStatePropertyAll(Colors.black12),
                              padding: const WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                MdiIcons.home,
                                color: Colors.black,
                              ),
                              horizontalSpace(10),
                              Text(
                                "Back to home",
                                style: titleSmall(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            BlocProvider.of<MockTestBloc>(context)
                                .add(LoadTestEvent());
                            context.pop();
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.4)),
                              overlayColor:
                                  const WidgetStatePropertyAll(Colors.black12),
                              padding: const WidgetStatePropertyAll(
                                  EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 12))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Retake test",
                                style: titleSmall(context),
                              ),
                              horizontalSpace(10),
                              Icon(
                                MdiIcons.reload,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(8)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String getScore(MockTestState state) {
    if (state is TestLoaded) {
      return "${state.score}/${state.questions.length}";
    }
    return "";
  }
}
