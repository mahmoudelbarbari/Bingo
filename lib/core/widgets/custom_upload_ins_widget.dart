import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class UploadFilesInsWidget extends StatelessWidget {
  final String title;
  final String firstText;
  UploadFilesInsWidget({required this.title, required this.firstText});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
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
              AppLocalizations.of(context)?.acceptanceFormate ??
                  "- ${loc.acceptedFormatsJPGPNGPDFMaxSize2MB}",
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
              AppLocalizations.of(context)?.photo_requirements ??
                  "- ${loc.noGlareReflectionsOrCroppedEdges}",
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
