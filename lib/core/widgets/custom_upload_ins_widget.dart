import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class UploadFilesInsWidget extends StatelessWidget {
  String title;
  String firstText;
  UploadFilesInsWidget({required this.title, required this.firstText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "- $firstText",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF777777),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)?.acceptanceFormate ?? "- Accepted formats: JPG, PNG, PDF | Max size: 2MB.",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF777777),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppLocalizations.of(context)?.photo_requirements??"- No glare, reflections, or cropped edges.",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF777777),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
