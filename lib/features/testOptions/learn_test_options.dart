import 'package:dri_learn/core/router_config.dart';
import 'package:dri_learn/core/spaces.dart';
import 'package:dri_learn/core/text_style.dart';
import 'package:dri_learn/features/tests/core/domain/question_type_model.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_bloc.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../authentication/domain/model/user_entity.dart';

class LearnTestOptions extends StatelessWidget {
  final User user;
  const LearnTestOptions({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            child: Card(
              margin: const EdgeInsets.all(0),
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Stack(
                children: [
                  ClipRRect(
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
                  Container(
                    color: Colors.black.withOpacity(0.4),
                  ),
                  Positioned(
                      top: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      if (context.canPop()) {
                                        context.pop();
                                      }
                                    },
                                    icon: Icon(
                                      MdiIcons.chevronLeft,
                                      size: 26,
                                    ),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  Card(
                                    color:
                                        Theme.of(context).colorScheme.surface,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onBackground,
                                            width: 0.1)),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 3, 5, 3),
                                      child: Row(
                                        children: [
                                          Text(
                                            user.name ?? "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                          horizontalSpace(7),
                                          Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onBackground,
                                                shape: BoxShape.circle),
                                            child: ClipOval(
                                              child: Image.asset(
                                                "assets/images/onboard_img.jpeg",
                                                fit: BoxFit.cover,
                                                width: 40,
                                                height: 40,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(10),
                              Center(
                                  child: Text(
                                "Knowledge | Road Sign",
                                style: titleLarge(context).copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.20,
                left: 15,
                right: 15),
            child: Column(
              children: [
                mockTestOptionCard(context, "Knowledge test", MdiIcons.book,
                    () {
                  BlocProvider.of<MockTestBloc>(context).add(
                      const SetQuestionType(
                          questionType: QuestionType.Knowledge));
                  context.push(ScreenRoutes.testDescription().route);
                }),
                verticalSpace(15),
                mockTestOptionCard(context, "Road sign test", MdiIcons.road,
                    () {
                  BlocProvider.of<MockTestBloc>(context).add(
                      const SetQuestionType(questionType: QuestionType.Sign));
                  context.push(ScreenRoutes.testDescription().route);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Card mockTestOptionCard(
      BuildContext context, String title, IconData icon, VoidCallback onClick) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        tileColor: Theme.of(context).colorScheme.secondary,
        textColor: Colors.white,
        iconColor: Colors.white,
        onTap: onClick,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      ),
    );
  }
}
