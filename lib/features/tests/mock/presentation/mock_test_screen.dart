import 'package:dri_learn/core/spaces.dart';
import 'package:dri_learn/core/text_style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MockTestScreen extends StatefulWidget {
  const MockTestScreen({super.key});

  @override
  State<MockTestScreen> createState() => _MockTestScreenState();
}

class _MockTestScreenState extends State<MockTestScreen> {
  String? _selectedAnswer;

  void _handleRadioValueChange(String? value) {
    setState(() {
      _selectedAnswer = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    double imageHeight = MediaQuery.of(context).size.height * 0.35;
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color:
                            Theme.of(context).colorScheme.primary.withAlpha(50),
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.elliptical(30, 30))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 6),
                      child: Text(
                        "Questions 1/20",
                        style: titleMedium(context).copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  verticalSpace(20),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.2),
                    child: Center(
                      child: Text(
                        "The road sign above symbolizes what",
                        style: titleLarge(context, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const Spacer(),
                  questionOptionWidget(context),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () {},
                              icon: Icon(
                                MdiIcons.television,
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                              label: Text(
                                "Visual learning",
                                style: titleSmall(context).copyWith(),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withAlpha(80)),
                                  padding: const MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 18))),
                            ),
                          ),
                          horizontalSpace(10),
                          Expanded(
                            child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Theme.of(context).colorScheme.primary),
                                  overlayColor: const MaterialStatePropertyAll(
                                      Colors.black12),
                                  padding: const MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 18))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Next",
                                    style: titleSmall(context)
                                        .copyWith(color: Colors.white),
                                  ),
                                  horizontalSpace(10),
                                  Icon(
                                    MdiIcons.redo,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .background,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Column questionOptionWidget(BuildContext context) {
    var list = [1, 2, 3, 4];
    return Column(
      children: list.map((e) {
        return Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          color: _selectedAnswer == "Answer 1"
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.background,
          surfaceTintColor: Colors.white,
          elevation: 1,
          child: ListTile(
            title: Text(
              "Answer 1",
              style: titleSmall(context).copyWith(
                  color: _selectedAnswer == "Answer 1"
                      ? Colors.white
                      : Theme.of(context).colorScheme.onBackground),
            ),
            trailing: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: _selectedAnswer == "Answer 1"
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.background,
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary)),
              child: Center(
                child: Icon(
                  _selectedAnswer == "Answer 1" ? MdiIcons.check : null,
                  color: Theme.of(context).colorScheme.background,
                ),
              ),
            ),
            onTap: () {
              _handleRadioValueChange("Answer 1");
            },
          ),
        );
      }).toList(),
    );
  }
}
