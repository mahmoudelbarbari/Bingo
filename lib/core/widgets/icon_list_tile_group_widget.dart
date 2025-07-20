import 'package:flutter/material.dart';

class RoundedListItem {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? trailing;
  RoundedListItem({
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
  });
}

class IconListTileGroupWidget extends StatelessWidget {
  final String? heading;
  final List<RoundedListItem> items;
  const IconListTileGroupWidget({
    super.key,
    this.heading,
    required this.items,
    required IconData icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heading != null)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(heading!, style: Theme.of(context).textTheme.bodyLarge),
          ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          child: Column(
            children: items.map((item) {
              return ListTile(
                leading: Icon(
                  item.icon,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(item.title),
                trailing:
                    item.trailing ??
                    const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: item.onTap,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
