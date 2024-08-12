import 'package:dri_learn/core/router_config.dart';
import 'package:dri_learn/core/spaces.dart';
import 'package:dri_learn/core/text_style.dart';
import 'package:dri_learn/features/history/presentation/history_screen.dart';
import 'package:dri_learn/features/home/home_page_widget.dart';
import 'package:dri_learn/features/tests/core/domain/model/test_type.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_bloc.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../authentication/domain/model/user_entity.dart';

class HomePageScreen extends StatefulWidget {
  final User user;
  const HomePageScreen({super.key, required this.user});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Card(
            color: Theme.of(context).colorScheme.surface,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                    color: Theme.of(context).colorScheme.onBackground,
                    width: 0.1)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 3, 5, 3),
              child: Row(
                children: [
                  Text(
                    widget.user.name ?? "",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  horizontalSpace(7),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onBackground,
                        shape: BoxShape.circle),
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/onboard_img.jpeg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePageWidget(user: widget.user),
          HistoryScreen(
            user: widget.user,
            showHeader: false,
          ),
        ],
      ),
      bottomNavigationBar: Card(
        elevation: 15,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  MdiIcons.home,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(MdiIcons.history), label: "History"),
          ],
          enableFeedback: true,
        ),
      ),
      drawer: drawer(context),
    );
  }

  Drawer drawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "assets/images/onboard_img.jpeg",
              fit: BoxFit.cover, // This makes the image cover the entire area
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ListTile(
            leading: const Icon(Icons.book_rounded),
            title: const Text('G1 Mock Test'),
            onTap: () {
              BlocProvider.of<MockTestBloc>(context)
                  .add(const SetTestType(testType: TestType.MockTest));
              Navigator.pop(context);
              context.push(ScreenRoutes.mockTest().route);
              // Handle navigation to Settings
            },
            iconColor: Theme.of(context).colorScheme.primary,
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.grass_sharp),
            title: const Text('History'),
            onTap: () {
              Navigator.of(context).pop();
              context.push(ScreenRoutes.testHistory().route,
                  extra: widget.user);
            },
            iconColor: Theme.of(context).colorScheme.primary,
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.grass_sharp),
            title: const Text('Knowledge Test'),
            onTap: () {
              Navigator.of(context).pop();
              BlocProvider.of<MockTestBloc>(context)
                  .add(const SetTestType(testType: TestType.Knowledge));
              context.push(ScreenRoutes.mockTest().route);
            },
            iconColor: Theme.of(context).colorScheme.primary,
          ),
          Divider(),
          ListTile(
            leading: const Icon(Icons.grass_sharp),
            title: const Text('Road Sign Test'),
            onTap: () {
              Navigator.of(context).pop();
              BlocProvider.of<MockTestBloc>(context)
                  .add(const SetTestType(testType: TestType.Sign));
              context.push(ScreenRoutes.mockTest().route);
            },
            iconColor: Theme.of(context).colorScheme.primary,
          ),
        ],
      ),
    );
  }
}
