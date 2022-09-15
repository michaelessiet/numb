import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:numb/engines/main.dart';
import 'package:numb/services/db/db.dart';
import 'package:numb/theme/theme.dart';

Future main() async {
  dotenv.load();
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
    // TODO: implement initState
    super.initState();
    appTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: appTheme.themeMode,
      darkTheme: ThemeData(primarySwatch: Colors.red),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inconsolata',
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  bool switchVal = false;

  @override
  void initState() {
    db.init();
    // Timer(const Duration(seconds: 1), (() => db.wipe()));
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
    return Scaffold(
      appBar: AppBar(
        title: Text(calcresult.toString(),
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 32)),
      ),
      body: Column(
        children: [
          Center(
            child: TextField(autocorrect: false, onChanged: calculate),
          ),
          Switch(
              value: switchVal,
              onChanged: ((value) {
                appTheme.toggleTheme();
                setState(() {
                  switchVal = !switchVal;
                });
              })),
          Text(appTheme.themeMode.toString())
        ],
      ),
    );
  }
}
