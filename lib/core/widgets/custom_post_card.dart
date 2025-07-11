import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class PostCardWidget extends StatelessWidget {
  String name;
  String profileImgPath;
  String time;
  String postDes;
  String? postImagePath;
  VoidCallback lovefun, commentFun;

  PostCardWidget({
    required this.name,
    required this.time,
    required this.profileImgPath,
    required this.postDes,
    this.postImagePath,
    required this.lovefun,
    required this.commentFun,
  });

  @override
  Widget build(BuildContext context) {
    final loc=AppLocalizations.of(context);
    return Card(
      margin: EdgeInsets.all(25),
      elevation: 6,
      // color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                "Possted $time",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.withOpacity(.5),
                ),
              ),
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(profileImgPath),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 22),
              child: ReadMoreText(
                postDes,
                trimLines: 3,
                trimExpandedText: 'Show Less',
                lessStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFAF1239),
                ),
                trimCollapsedText: 'Read More',
                moreStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFAF1239),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(postImagePath ?? ""),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.grey,
                  ),
                ),
                Text(loc!.loveIt, style: TextStyle(color: Colors.grey)),
                SizedBox(width: 12),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.insert_comment_outlined, color: Colors.grey),
                ),
                Text(loc.comment, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
