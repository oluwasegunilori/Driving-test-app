import 'package:dri_learn/core/router_config.dart';
import 'package:dri_learn/core/spaces.dart';
import 'package:dri_learn/core/text_style.dart';
import 'package:dri_learn/features/authentication/domain/model/user_entity.dart';
import 'package:dri_learn/features/tests/core/domain/model/test_type.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_bloc.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePageWidget extends StatelessWidget {
  final User user;
  const HomePageWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            "Get Ready to Ace Your Driving Test with Confidence",
            style: Theme.of(context).textTheme.displaySmall!.copyWith(),
            textAlign: TextAlign.center,
          ),
        ),
        verticalSpace(10),
        Expanded(
            child: Padding(
          padding: EdgeInsets.fromLTRB(
              20, 10, 20, MediaQuery.of(context).size.height * 0.07),
          child: Column(
            children: [
              homeOptions(
                  image: "assets/images/onboard_img.jpeg",
                  onTop: inImageTItles(context,
                      bigTitle: "Mock Test",
                      bodyTitle:
                          "Test your knowledge and\ntrack your progress"),
                  clicked: () => {
                        BlocProvider.of<MockTestBloc>(context).add(
                            const SetTestType(testType: TestType.MockTest)),
                        context.push(ScreenRoutes.mockTestOptions().route,
                            extra: user)
                      }),
              verticalSpace(MediaQuery.of(context).size.height * 0.03),
              homeOptions(
                  image: "assets/images/school_crooss.jpeg",
                  onTop: inImageTItles(context,
                      bigTitle: "Learn",
                      bodyTitle:
                          "Discover lessons and tips\nto ace your driving test"),
                  clicked: () => {
                        context.push(ScreenRoutes.learnTestOptions().route,
                            extra: user)
                      }),
            ],
          ),
        ))
      ],
    );
  }
}

Expanded homeOptions(
    {required String image,
    required Widget onTop,
    required VoidCallback clicked}) {
  return Expanded(
      child: Stack(
    children: [
      InkWell(
        onTap: clicked,
        child: Card(
          margin: const EdgeInsets.all(0),
          elevation: 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(
                15.0), // Adjust the border radius as needed
            child: Stack(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit
                      .cover, // This makes the image cover the entire area
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  color: Colors.black.withOpacity(0.6),
                )
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: onTop,
      ),
      Positioned(
        bottom: 10,
        right: 20,
        child: IconButton(
          onPressed: clicked,
          icon: Icon(
            MdiIcons.arrowRight,
            color: Colors.white,
          ),
          iconSize: 40,
        ),
      )
    ],
  ));
}

Column inImageTItles(BuildContext context,
    {required String bigTitle, required String bodyTitle}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(bigTitle,
          style: titleLarge(context).copyWith(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40)),
      verticalSpace(10),
      Text(
        bodyTitle,
        style: titleSmall(context).copyWith(color: Colors.white),
      )
    ],
  );
}
