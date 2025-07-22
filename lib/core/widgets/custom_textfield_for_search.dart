import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TextFieldForSearch extends StatefulWidget {
  final TextEditingController controller;
  final bool isRTL;

  const TextFieldForSearch({
    super.key,
    required this.controller,
    required this.isRTL,
  });

  @override
  State<TextFieldForSearch> createState() => _TextFieldForSearchState();
}

class _TextFieldForSearchState extends State<TextFieldForSearch> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      padding: EdgeInsets.symmetric(vertical: 2.h),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          ?isDark
              ? null
              : BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        textAlign: widget.isRTL ? TextAlign.right : TextAlign.left,
        decoration: InputDecoration(
          filled: true,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          hintText: AppLocalizations.of(context)!.search,
          hintStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
        ),
      ),
    );
  }
}
