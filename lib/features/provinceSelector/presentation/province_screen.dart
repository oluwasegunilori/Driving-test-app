import 'package:dri_learn/core/button_styles.dart';
import 'package:dri_learn/core/spaces.dart';
import 'package:dri_learn/core/text_style.dart';
import 'package:dri_learn/features/provinceSelector/presentation/province_bloc.dart';
import 'package:dri_learn/features/provinceSelector/presentation/province_event.dart';
import 'package:dri_learn/utils/onboarding_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '/core/di/injection_container.dart' as di;
import 'province_state.dart';

class ProvinceSelector extends StatelessWidget {
  const ProvinceSelector({super.key});

  @override
  Widget build(BuildContext context) {
    ProvinceBloc bloc = di.sl.get<ProvinceBloc>();
    return BlocProvider(
      create: (context) {
        bloc.add(GetProvinceEvent());
        return bloc;
      },
      child: BlocBuilder<ProvinceBloc, ProvinceState>(
        builder: (context, state) {
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
                          child: (state is DoneState)
                              ? Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Center(
                                      child: Text(
                                        "Select your province",
                                        style: titleMedium(context,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    verticalSpace(15),
                                    ...state.provinces.map((e) => Column(
                                          children: [
                                            ListTile(
                                              title: Text(e.name),
                                              trailing: Checkbox(
                                                  value: state.selectedProvinces
                                                          .contains(e) ==
                                                      true,
                                                  onChanged: (_) => {
                                                        bloc.add(
                                                            SelectProvinceEvent(
                                                                province: e))
                                                      }),
                                            ),
                                            Divider(),
                                          ],
                                        )),
                                    const Spacer(),
                                    primaryButton(
                                        context: context,
                                        text: "Continue",
                                        onClick: () {
                                          // context.go(location)
                                        })
                                  ],
                                )
                              : (state is LoadingState)
                                  ? LinearProgressIndicator()
                                  : Center(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]));
        },
      ),
    );
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
