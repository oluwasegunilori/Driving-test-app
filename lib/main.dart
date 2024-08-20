import 'dart:async';

import 'package:dri_learn/config/env.dart';
import 'package:dri_learn/features/authentication/presentation/authentication_bloc.dart';
import 'package:dri_learn/features/gemini/presentation/bloc/gemini_bloc.dart';
import 'package:dri_learn/features/tests/mock/presentation/mock_test_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dri_learn/core/router_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'features/authentication/domain/model/user_entity.dart';
import 'features/authentication/presentation/authentication_state.dart';
import 'firebase_options.dart';
import './core/di/injection_container.dart' as di;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Gemini.init(apiKey: Env.geminiAPIKEY);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final User? user;

  const MyApp({this.user, super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
            create: (BuildContext context) => di.sl<AuthBloc>()),
        BlocProvider<MockTestBloc>(
            create: (BuildContext context) => di.sl<MockTestBloc>()),
        BlocProvider<GeminiBloc>(
            create: (BuildContext context) => di.sl<GeminiBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.black,
              primary: const Color(0XFFfd7e14),
              secondary: const Color(0xFF04044A),
              tertiary: const Color(0xFF020222),
              error: Colors.red),
          useMaterial3: true,
        ),
        routerConfig: appRouter,
        themeMode: ThemeMode.system,
        darkTheme: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.fromSeed(
                brightness: Brightness.dark,
                seedColor: Colors.black,
                primary: const Color(0XFFfd7e14),
                secondary: const Color(0xFF04044A),
                tertiary: const Color(0xFF020222),
                error: Colors.red)),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Done) {
              return Text(state.user?.name ?? "Email");
            }
            return Text("Title");
          },
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
