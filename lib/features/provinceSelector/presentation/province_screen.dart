import 'package:dri_learn/core/spaces.dart';
import 'package:dri_learn/core/text_style.dart';
import 'package:dri_learn/utils/onboarding_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProvinceSelector extends StatelessWidget {
  const ProvinceSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      SizedBox(
          height: MediaQuery.of(context).size.height / 3.5,
          child: Card(
              margin: const EdgeInsets.all(0),
              shadowColor: Colors.white,
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                        15.0), // Adjust the border radius as needed
                    child: Image.asset(
                      onboardingPages.first,
                      fit: BoxFit
                          .cover, // This makes the image cover the entire area
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ],
              ))),
      SafeArea(
        child: Column(
          children: [
            titleAndIcon(
              context,
            ),
            verticalSpace(10),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                    top: Radius.elliptical(
                        MediaQuery.of(context).size.width / 2,
                        MediaQuery.of(context).size.height *
                            0.07)), // Adjust the border radius as needed
                child: Container(
                  color: Theme.of(context).colorScheme.background,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Select your province",
                          style:
                              titleMedium(context, fontWeight: FontWeight.w600),
                        ),
                        verticalSpace(15),
                        ListView(
                          children: [
                            
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ]));
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height / 2);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height / 2,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
