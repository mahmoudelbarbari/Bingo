import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

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
            SizedBox(height: 12,),
            UploadFilesInsWidget(title: "For your Selfie with ID:", firstText:"Face and ID must be clear.")
          ],
        ),
      ),
    );
  }
}

class UserType extends StatelessWidget {
  String text;
  String imgPath;
  UserType({required this.text, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.withOpacity(.3), width: 2),
      ),
      margin: EdgeInsets.symmetric(horizontal: 27, vertical: 20),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Image.asset(imgPath),
        ],
      ),
    );
  }
}

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
                    color: Theme.of(context).colorScheme.secondary,
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
                    ).colorScheme.secondary.withOpacity(.5),
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
            padding: EdgeInsets.only(left: 70),
            child: TextButton(
              style: TextButton.styleFrom(),
              onPressed: () {},
              child: Text(
                "Reply",
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(
                    context,
                  ).colorScheme.secondary.withOpacity(.7),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ElevatedButtonWidget extends StatelessWidget {
  VoidCallback fun;
  String text;
  bool isColored;
  ElevatedButtonWidget({
    required this.fun,
    required this.text,
    required this.isColored,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(9),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: isColored
              ? const Color(0xFFAF1239)
              : Colors.grey.withOpacity(.7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: fun,
        child: Text(text, style: TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  String text1;
  String text2;
  VoidCallback fun;
  TextButtonWidget({
    required this.fun,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: fun,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$text1 ",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: const Color.fromARGB(255, 116, 116, 116),
            ),
          ),
          Text(
            text2,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 15,
              color: const Color(0xFFAF1239),
            ),
          ),
        ],
      ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey.withOpacity(.7),
            thickness: 2,
            indent: 10,
          ),
        ),
        Text(
          "  Or  ",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey.withOpacity(.7),
            thickness: 2,
            endIndent: 10,
          ),
        ),
      ],
    );
  }
}

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
                Text("Love it", style: TextStyle(color: Colors.grey)),
                SizedBox(width: 12),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.insert_comment_outlined, color: Colors.grey),
                ),
                Text("Comment", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldForInstructions extends StatelessWidget {
  String title;
  String hintText;
  TextFieldForInstructions({required this.title, required this.hintText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          TextField(
            cursorColor: Colors.grey[600],
            maxLines: 7,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.grey.withOpacity(.5),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 10),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextFieldForSearch extends StatelessWidget {
  const TextFieldForSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextField(
        cursorColor: Colors.grey[600],
        decoration: InputDecoration(
          hintText: "Search",
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

class SwitchWidget extends StatefulWidget {
  String title;
  bool switchValue = true;
  SwitchWidget({required this.title});

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Switch(
            value: widget.switchValue,
            onChanged: (value) {
              setState(() {
                widget.switchValue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class UploadFilesInsWidget extends StatelessWidget {
  String title;
  String firstText;
   UploadFilesInsWidget({required this.title,required this.firstText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("- $firstText",style: TextStyle(fontSize:15,fontWeight: FontWeight.bold, color: const Color(0xFF777777) ),),
           ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("- Accepted formats: JPG, PNG,PDF| Max size: 2MB.",style: 
            TextStyle(fontSize:15,fontWeight: FontWeight.bold, color: const Color(0xFF777777) ),),
           ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("- No glare, reflections, or cropped edges.",
            style: TextStyle(fontSize:15,fontWeight: FontWeight.bold, color: const Color(0xFF777777)),),
           ),
        ],
      ),
    );
  }
}
