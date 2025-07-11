import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  String text1;
  String text2;
  VoidCallback fun;
  
  TextButtonWidget({
    required this.fun,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: fun,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$text1 ",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: const Color.fromARGB(255, 116, 116, 116),
            ),
          ),
          Text(
            text2,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: const Color(0xFFAF1239),
            ),
          ),
        ],
      ),
    );
  }
}

