import 'package:ontario_g1_test_2024/ads/sections/banner_ad.dart';
import 'package:ontario_g1_test_2024/core/button_styles.dart';
import 'package:ontario_g1_test_2024/core/spaces.dart';
import 'package:ontario_g1_test_2024/core/text_style.dart';
import 'package:ontario_g1_test_2024/features/authentication/domain/model/user_entity.dart';
import 'package:ontario_g1_test_2024/features/history/domain/model/test_history_item.dart';
import 'package:ontario_g1_test_2024/features/history/presentation/bloc/test_history_bloc.dart';
import 'package:ontario_g1_test_2024/features/history/presentation/circle_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '/core/di/injection_container.dart' as di;

class HistoryScreen extends StatefulWidget {
  final User user;
  final bool showHeader;
  const HistoryScreen({super.key, required this.user, this.showHeader = true});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late BannerAd _bannerAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    loadAd(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }
          setState(() {
            _bannerAd = ad as BannerAd;
          });
          _isAdLoaded = true;
        },
        adSize: AdSize.mediumRectangle);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl.get<TestHistoryBloc>(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Column(
            children: [
              if (widget.showHeader) ...[
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
                                          color: Theme.of(context)
                                              .colorScheme
                                              .surface,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                                                  widget.user.name ?? "",
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpace(13),
              ],
              BlocBuilder<TestHistoryBloc, TestHistoryState>(
                builder: (context, state) {
                  if (state is TestHistoryLoaded) {
                    return Column(
                      children: [
                        Column(
                            children: state.data.values
                                .map((e) =>
                                    mockTestOptionCard(context, e, () {}))
                                .toList()),
                        if (_isAdLoaded) ...[
                          verticalSpace(20),
                          Center(
                            child: SizedBox(
                              height: _bannerAd.size.height.toDouble(),
                              width: _bannerAd.size.width.toDouble(),
                              child: AdWidget(ad: _bannerAd),
                            ),
                          ),
                        ]
                      ],
                    );
                  }
                  return Center();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget mockTestOptionCard(
      BuildContext context, TestHistoryItem item, VoidCallback onClick) {
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
                      size: const Size(150, 150),
                      painter: CirclePainter(
                          whiteSize: Size(1 - item.averageScore.toDouble(),
                              item.averageScore.toDouble()),
                          buildContext: context),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${item.averageScore.toString()}%",
                            style: titleMedium(context)
                                .copyWith(fontWeight: FontWeight.bold)),
                        Text("Score",
                            style: titleSmall(context).copyWith(fontSize: 9)),
                      ],
                    ),
                  ],
                ),
                title: Text(item.testType.value),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                iconColor: Theme.of(context).colorScheme.primary,
                onTap: null,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                tileColor: Theme.of(context).colorScheme.surface,
              ),
            ),
            verticalSpace(5),
            if (item.lastThree() != null) ...[
              Text(
                "Last three scores:",
                style: titleSmall(context)
                    .copyWith(color: Theme.of(context).colorScheme.primary),
              ),
              Text(
                item.lastThree()!,
                style: titleSmall(context),
              ),
              verticalSpace(5)
            ] else ...[
              Text(
                "No attempts made",
                style: titleSmall(context)
                    .copyWith(color: Theme.of(context).colorScheme.error),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
