import 'package:bingo/core/widgets/custom_comment_widget.dart';
import 'package:bingo/core/widgets/custom_divider_widget.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/core/widgets/custom_post_card.dart';
import 'package:bingo/core/widgets/custom_switch_widget.dart';
import 'package:bingo/core/widgets/custom_text_button.dart';
import 'package:bingo/core/widgets/custom_textfield_for_instructions.dart';
import 'package:bingo/core/widgets/custom_textfield_for_search.dart';
import 'package:bingo/core/widgets/custom_upload_ins_widget.dart';
import 'package:bingo/core/widgets/custom_user_type.dart';
import 'package:bingo/l10n/app_localizations.dart' show AppLocalizations;
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import 'core/util/size_config.dart';

class CustomeWidgets extends StatefulWidget {
  const CustomeWidgets({super.key});

  @override
  State<CustomeWidgets> createState() => _CustomeWidgetsState();
}

class _CustomeWidgetsState extends State<CustomeWidgets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 30),
          children: [
            UserType(text: "Seller", imgPath: "assets/images/seller_img.png"),
            CommentsWidget(
              time: "2 days ago",
              name: "Nour Ahmed",
              comment: "Nice one! looking forward to more",
              imgPath: "assets/images/seller_img.png",
            ),
            SizedBox(height: 12),
            ElevatedButtonWidget(fun: () {}, text: "Log in", isColored: true),
            SizedBox(height: 12),
            TextButtonWidget(
              fun: () {},
              text1: "Don't have an account?",
              text2: "Sign Up",
            ),
            SizedBox(height: 12),
            DividerWidget(),
            SizedBox(height: 12),
            PostCardWidget(
              name: "Sara Ahmed",
              time: "3 h ago",
              profileImgPath: "assets/images/seller_img.png",
              postDes:
                  "sd; u jhlk jlijlk k jhklhjklhlkhl kljkjlk hg hjhgjh g gjgjkgjk hklhjklj nhhklj;lkjljljk;lk;lk;l jl;jl;kl;k;llk;l  mbdmnbcm bnjkewnhkjqhjkw nmkdnw.,qnd hjkgjh jkhkhkjh bjmbhkjhn bjkhkjh bjukjk nm,nk,endwlkqmndf  nm,nwedmnewk,  njkenwkjqdnjkew ewkjkndfkjewnkldnwe.,;. kwhkhjkdwjdk kqpskl;ql l;'lsq  '; plsqplsp; ;'ksqwk ",
              postImagePath: "assets/images/post img.png",
              lovefun: () {},
              commentFun: () {},
            ),
            SizedBox(height: 12),

            TextFieldForInstructions(
              title: "Instructions for buyers",
              hintText: "Enter any Special instructions for buyers here...",
            ),
            SizedBox(height: 12),
            TextFieldForSearch(),
            SizedBox(height: 12),
            SwitchWidget(title: "Personalization Avilable"),
            SizedBox(height: 12),
            UploadFilesInsWidget(
              title: "For your Selfie with ID:",
              firstText: "Face and ID must be clear.",
            ),
          ],
        ),
      ),
    );
  }
}
