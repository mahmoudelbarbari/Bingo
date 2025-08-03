import 'package:flutter/material.dart';

class TextFieldForInstructions extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController textEditingController;
  final String? Function(String?)? formFieldValidator;

  const TextFieldForInstructions({
    super.key,
    this.formFieldValidator,
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
        TextFormField(
          cursorColor: Colors.grey[600],
          maxLines: 7,
          controller: textEditingController,
          validator: formFieldValidator,
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
