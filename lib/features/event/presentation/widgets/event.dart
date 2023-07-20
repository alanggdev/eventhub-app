import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/event/presentation/pages/event_screen.dart';
import 'package:eventhub_app/features/event/domain/entities/event.dart';
import 'package:eventhub_app/keys.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';

Padding eventWidget(BuildContext context, Event userEvent, User user) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EventScreen(userEvent, user)));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorStyles.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    userEvent.name,
                    style: const TextStyle(
                      color: ColorStyles.primaryGrayBlue,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    userEvent.date,
                    style: const TextStyle(
                      color: ColorStyles.primaryGrayBlue,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AspectRatio(
                  aspectRatio: 64 / 25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: FadeInImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.center,
                      image: NetworkImage(
                          '$serverURL${userEvent.imagePaths![0]}'),
                      placeholder: const AssetImage(Images.eventPlaceholder),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return const Center(child: Text('event image'));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Chip eventCategoryLabel(dynamic category) {
  return Chip(
    backgroundColor: ColorStyles.secondaryColor1,
    labelStyle: const TextStyle(
      color: ColorStyles.baseLightBlue,
      fontFamily: 'Inter',
      fontSize: 12,
    ),
    label: Text(category),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

Container eventImage(dynamic image) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 0,
          blurRadius: 5,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: AspectRatio(
      aspectRatio: 64 / 25,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: FadeInImage(
            fit: BoxFit.fitWidth,
            alignment: FractionalOffset.center,
            image: NetworkImage('$serverURL$image'),
            placeholder: const AssetImage(Images.eventPlaceholder),
            imageErrorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('event image'));
            },
          ),
        ),
      ),
    ),
  );
}
