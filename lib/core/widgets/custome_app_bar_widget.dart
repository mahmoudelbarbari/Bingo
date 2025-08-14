import 'package:flutter/material.dart';

import '../../config/theme_app.dart';

class CustomeAppBarWidget extends PreferredSize {
  final String? title;
  final String? subTitle;
  final bool hideBackButton;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
  final TextStyle? textStyle;

  const CustomeAppBarWidget({
    super.key,
    super.preferredSize = const Size.fromHeight(kToolbarHeight),
    super.child = const SizedBox.shrink(),
    this.title,
    this.subTitle,
    this.leading,
    this.actions,
    this.hideBackButton = true,
    this.centerTitle = true,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      actions: actions,
      leading: leading,
      title: ListTile(
        title: Text(
          '$title',
          style:
              textStyle ??
              TextStyle(fontSize: lightTheme.textTheme.headlineLarge!.fontSize),
        ),
        subtitle: Text(
          subTitle ?? "",
          style: lightTheme.textTheme.bodySmall!.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      automaticallyImplyLeading: hideBackButton,
      centerTitle: centerTitle,
    );
  }
}
