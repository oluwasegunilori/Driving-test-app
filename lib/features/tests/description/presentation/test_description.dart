import 'package:dri_learn/core/button_styles.dart';
import 'package:dri_learn/core/router_config.dart';
import 'package:dri_learn/core/spaces.dart';
import 'package:dri_learn/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TestDescripScreen extends StatelessWidget {
  const TestDescripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double imageHeight = MediaQuery.of(context).size.height * 0.35;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
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
                                  'Title',
                                  style: titleMedium(context)
                                      .copyWith(color: Colors.white),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                Positioned(
                  top: 50,
                  child: IconButton(
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
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(50),
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.all(
                              Radius.elliptical(30, 30))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 6),
                        child: Text(
                          "20 Questions",
                          style: titleMedium(context).copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    verticalSpace(20),
                    const Text(
                        "This Test is designed to evaluate your knowledge of road rules, driving  techniques, and safety practices. Dive into realistic practice tests  that will help you gain confidence and ensure you're ready to hit the  road with skill and assurance."),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        primaryButton(
                            context: context,
                            text: "Begin Test",
                            onClick: () {
                              context.push(ScreenRoutes.testComplete().route);
                            }),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
