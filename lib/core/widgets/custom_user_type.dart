import 'package:flutter/material.dart';

class UserType extends StatelessWidget {
  final String text;
  final String imgPath;
  UserType({required this.text, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(.3), width: 2),
      ),
      margin: EdgeInsets.symmetric(horizontal: 27, vertical: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Image.asset(imgPath),
        ],
      ),
    );
  }
}
