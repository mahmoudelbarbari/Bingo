import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/event.dart';

class EventsTab extends StatelessWidget {
  final List<Event> events;

  const EventsTab({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return Center(
        child: Text(AppLocalizations.of(context)!.thereAreNoEventsCurrently),
      );
    }

    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: ListTile(
            title: Text(event.title),
            subtitle: Text(event.description),
            // trailing: Text(event.),
          ),
        );
      },
    );
  }
}
