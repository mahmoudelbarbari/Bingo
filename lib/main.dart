import 'dart:async';

import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/bloc_observer/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runZonedGuarded(() async {
    Bloc.observer = MyGlobalObserver();

    runApp(const MyApp());
  }, (e, s) {});
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme,
      home: Scaffold(body: Center(child: Text("data"))),
    );
  }
}
