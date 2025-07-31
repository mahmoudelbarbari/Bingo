import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SavedAddressPage extends StatelessWidget {
  SavedAddressPage({super.key});

  final List<String> addresses = [
    'Department 7, Building 12, Apartment 5',
    'Department 3, Building 8, Apartment 12',
    'Department 9, Building 5, Apartment 3',
  ];

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.address,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/addAddressScreen'),
            child: Text(loc.add, style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(thickness: 0.5, indent: 20);
        },
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              addresses[index],
              style: Theme.of(context).textTheme.titleMedium,
            ),
          );
        },
      ),
    );
  }
}
