import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:numb/engines/conversion%20engine/conversions/units/currency.dart';
import 'package:numb/engines/main.dart';
import 'package:numb/screens/helpscreen.dart';
import 'package:numb/screens/mainscreen.dart';
import 'package:numb/services/db/db.dart';
import 'package:numb/theme/theme.dart';
import 'package:timezone/data/latest.dart' as tz;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await db.init();
  dotenv.load().then((value) {
    getExchangeRate();
  });
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    appTheme.init();
    appTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: appTheme.themeMode,
      darkTheme: darkThemeData,
      theme: lightThemeData,
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(
              title: 'Flutter',
            ),
        'help': (context) => const HelpScreen()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  dynamic calcresult = 0;

  @override
  void initState() {
    super.initState();
  }

  void calculate(String text) {
    var result = numbEngine(text);
    setState(() {
      calcresult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MainCalcScreen();
  }
}
