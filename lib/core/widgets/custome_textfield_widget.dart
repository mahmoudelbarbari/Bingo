import 'package:flutter/material.dart';

class CustomeTextfieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? formFieldValidator;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool? isfilled;
  final bool isobscureText;
  final TextInputType? textInputType;
  final String? labelText;
  final bool isRTL;

  const CustomeTextfieldWidget({
    super.key,
    required this.controller,
    this.formFieldValidator,
    required this.prefixIcon,
    this.suffixIcon,
    this.isfilled,
    this.isobscureText = false,
    this.textInputType,
    this.labelText,
    required this.isRTL,
  });

  @override
  State<CustomeTextfieldWidget> createState() => _CustomeTextfieldWidgetState();
}

class _CustomeTextfieldWidgetState extends State<CustomeTextfieldWidget> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = _focusNode.hasFocus;
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      validator: widget.formFieldValidator,
      keyboardType: widget.textInputType,
      obscureText: widget.isobscureText,
      style: const TextStyle(fontSize: 20),
      textAlign: widget.isRTL ? TextAlign.right : TextAlign.left,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: IconTheme(
          data: IconThemeData(
            color: isFocused
                ? Colors.black
                : const Color.fromARGB(255, 199, 199, 199),
          ),
          child: widget.prefixIcon,
        ),
        labelText: widget.labelText,
        labelStyle: isFocused
            ? const TextStyle(color: Colors.black)
            : Theme.of(context).inputDecorationTheme.labelStyle,
        suffixIcon: widget.suffixIcon,
        hintStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
        border: Theme.of(context).inputDecorationTheme.border,
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
        errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
        focusedErrorBorder: Theme.of(
          context,
        ).inputDecorationTheme.focusedErrorBorder,
      ),
    );
  }
}
