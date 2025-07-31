import 'package:bingo/core/widgets/icon_list_tile_group_widget.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.settings,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconListTileGroupWidget(
              items: [
                RoundedListItem(title: loc.accountInfo),
                RoundedListItem(title: loc.changePassword),
              ],
              icon: Icons.person,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconListTileGroupWidget(
              items: [
                RoundedListItem(
                  title: loc.savedAddress,
                  onTap: () =>
                      Navigator.pushNamed(context, '/savedAddressScreen'),
                ),
              ],
              icon: Icons.person,
            ),
          ),
        ],
      ),
    );
  }
}
