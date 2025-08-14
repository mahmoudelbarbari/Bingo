import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/review.dart';

class ReviewsTab extends StatelessWidget {
  final List<Review> reviews;

  const ReviewsTab({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.thereAreNoReviewsCurrently),
      );
    }

    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: ListTile(
            title: Text(review.reviewerName),
            subtitle: Text(review.comment),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                5,
                (i) => Icon(
                  i < review.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 20,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
