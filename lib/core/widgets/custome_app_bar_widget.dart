import 'package:flutter/material.dart';

import '../../config/theme_app.dart';
import '../../l10n/app_localizations.dart';

class CustomeAppBarWidget extends PreferredSize {
  final String? title;
  final String? subTitle;
  final bool hideBackButton;
  final bool centerTitle;
  final List<Widget>? actions;
  final Widget? leading;
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
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return AppBar(
      elevation: 0,
      actions: actions,
      leading: leading,
      title: ListTile(
        title: Text(
          '${loc.welcome} $title,',
          style: TextStyle(
            fontSize: lightTheme.textTheme.headlineLarge!.fontSize,
          ),
        ),
        subtitle: Text(subTitle ?? "", style: lightTheme.textTheme.bodySmall),
      ),
      automaticallyImplyLeading: hideBackButton,
      centerTitle: centerTitle,
    );
  }
}
