import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String coverImageUrl;
  final String profileImageUrl;

  const ProfileHeader({
    super.key,
    required this.coverImageUrl,
    required this.profileImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child:
              (coverImageUrl.startsWith('http') ||
                  coverImageUrl.startsWith('https'))
              ? Image.network(
                  coverImageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image);
                  },
                )
              : Image.asset(
                  Assets.images.rectangle346246291.path,
                  fit: BoxFit.cover,
                ),
        ),

        Positioned(
          bottom: -40,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 37,
              backgroundImage:
                  (profileImageUrl.startsWith('http') ||
                      profileImageUrl.startsWith('https'))
                  ? NetworkImage(profileImageUrl) as ImageProvider
                  : const NetworkImage(
                      'https://img-s-msn-com.akamaized.net/tenant/amp/entityid/AA1zoMBS.img?w=768&h=1076&m=6&x=346&y=266&s=192&d=192',
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
