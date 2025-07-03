import 'package:flutter/material.dart';

class CustomeWidgets extends StatefulWidget {
  const CustomeWidgets({super.key});

  @override
  State<CustomeWidgets> createState() => _CustomeWidgetsState();
}

class _CustomeWidgetsState extends State<CustomeWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('data')));
  }
}
