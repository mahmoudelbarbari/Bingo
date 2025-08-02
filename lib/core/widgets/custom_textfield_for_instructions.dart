import 'package:flutter/material.dart';

class TextFieldForInstructions extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController textEditingController;

  const TextFieldForInstructions({
    super.key,
    required this.title,
    required this.hintText,
    required this.textEditingController,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TextField(
          cursorColor: Colors.grey[600],
          maxLines: 7,
          controller: textEditingController,

          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.grey.withOpacity(.5),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey, width: 10),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}
