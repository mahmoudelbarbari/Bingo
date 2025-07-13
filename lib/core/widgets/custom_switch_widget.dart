import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SwitchWidget extends StatefulWidget {
  String title;
  bool switchValue = true;
  SwitchWidget({required this.title});

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Switch(
            value: widget.switchValue,
            onChanged: (value) {
              setState(() {
                widget.switchValue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
