import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomeTextfieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? formFieldValidator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isfilled;
  final bool isobscureText;
  final TextInputType? textInputType;
  final String? labelText;
  final String? hintlText;
  final bool isRTL;
  final bool hasError;
  final bool isSuccess;
  final List<TextInputFormatter>? inputFormatters;

  const CustomeTextfieldWidget({
    super.key,
    required this.controller,
    this.formFieldValidator,
    this.prefixIcon,
    this.suffixIcon,
    this.isfilled,
    this.isobscureText = false,
    this.textInputType,
    this.labelText,
    required this.isRTL,
    this.hasError = false,
    this.isSuccess = false,
    this.hintlText,
    this.inputFormatters,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      focusNode: _focusNode,
      controller: widget.controller,
      validator: widget.formFieldValidator,
      keyboardType: widget.textInputType,
      obscureText: widget.isobscureText,
      style: const TextStyle(fontSize: 20),
      inputFormatters: widget.inputFormatters,
      textAlign: widget.isRTL ? TextAlign.right : TextAlign.left,
      decoration: InputDecoration(
        fillColor: widget.hasError
            ? (isDark ? Color(0xFF3A1F1F) : Color(0xFFFDF5F5))
            : widget.isSuccess
            ? (isDark ? Color(0xFF1F3A2B) : Color(0xFFF3FDF7))
            : null,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        prefixIcon: widget.prefixIcon != null
            ? IconTheme(
                data: IconThemeData(
                  color: isFocused
                      ? (isDark ? Colors.white : Colors.black)
                      : const Color.fromARGB(255, 199, 199, 199),
                ),
                child: widget.prefixIcon!,
              )
            : widget.prefixIcon,
        labelText: widget.labelText,
        hintText: widget.hintlText,
        labelStyle: isFocused
            ? const TextStyle(color: Colors.black)
            : Theme.of(context).inputDecorationTheme.labelStyle,
        suffixIcon: widget.suffixIcon,
        hintStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        filled: true,
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
