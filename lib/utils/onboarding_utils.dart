import 'package:flutter/material.dart';

final List<String> onboardingPages = [
  'assets/images/onboard_img.jpeg',
  'assets/images/onboard_img.jpeg',
];

Widget titleAndIcon(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "DriLearn",
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
  );
}
