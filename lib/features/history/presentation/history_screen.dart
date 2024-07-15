import 'package:dri_learn/core/button_styles.dart';
import 'package:dri_learn/core/spaces.dart';
import 'package:dri_learn/core/text_style.dart';
import 'package:dri_learn/features/authentication/domain/model/user_entity.dart';
import 'package:dri_learn/features/history/presentation/circle_painter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HistoryScreen extends StatelessWidget {
  final User user;
  const HistoryScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
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
                                                .onSurface,
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
                                                    .onSurface,
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
                              verticalSpace(13),
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Center(
                        child: Text(
                      "History",
                      style: titleLarge(context).copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ],
              ),
            ),
          ),
          verticalSpace(13),
          mockTestOptionCard(context, "title", Icons.abc_outlined, () {})
        ],
      ),
    );
  }

  Padding mockTestOptionCard(
      BuildContext context, String title, IconData icon, VoidCallback onClick) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                trailing: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomPaint(
                      size: const Size(180, 180),
                      painter: CirclePainter(
                          whiteSize: const Size(25, 75), buildContext: context),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("75%",
                            style: titleMedium(context)
                                .copyWith(fontWeight: FontWeight.bold)),
                        Text("Score",
                            style: titleSmall(context).copyWith(fontSize: 9)),
                      ],
                    ),
                  ],
                ),
                title: Text(title),
                subtitle: const Text("subtitle"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                iconColor: Theme.of(context).colorScheme.primary,
                onTap: null,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                tileColor: Theme.of(context).colorScheme.surface,
              ),
            ),
            verticalSpace(15),
            primaryButton(
                context: context, text: "View details", onClick: onClick)
          ],
        ),
      ),
    );
  }
}
