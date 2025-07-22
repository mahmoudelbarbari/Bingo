import 'package:bingo/config/theme_app.dart';
import 'package:flutter/material.dart';

class ViewSwitcherWidget extends StatelessWidget {
  final bool isGridView;
  final VoidCallback onGridTap;
  final VoidCallback onListTap;

  const ViewSwitcherWidget({
    super.key,
    required this.isGridView,
    required this.onGridTap,
    required this.onListTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Grid View Icon
          InkWell(
            onTap: onGridTap,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isGridView
                    ? lightTheme.primaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.grid_view,
                color: isGridView ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // List View Icon
          InkWell(
            onTap: onListTap,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: !isGridView
                    ? lightTheme.primaryColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.list,
                color: !isGridView ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
