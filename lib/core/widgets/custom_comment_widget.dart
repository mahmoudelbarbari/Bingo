import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CommentsWidget extends StatelessWidget {
  String name;
  String comment;
  String imgPath;
  String time;

  CommentsWidget({
    required this.time,
    required this.name,
    required this.comment,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
        final loc = AppLocalizations.of(context)!;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Row(
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(width: 9),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(.3),
                  ),
                ),
              ],
            ),
            subtitle: Text(comment),
            leading: CircleAvatar(
              radius: 22,

              backgroundImage: AssetImage(imgPath),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_border_outlined),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 60),
            child: TextButton(
              style: TextButton.styleFrom(),
              onPressed: () {},
              child: Text(
                loc.reply,
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
