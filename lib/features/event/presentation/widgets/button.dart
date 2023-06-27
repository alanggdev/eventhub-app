import 'package:flutter/material.dart';
import 'dart:io';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/event/presentation/widgets/alerts.dart';
import 'package:eventhub_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';

Padding eventOptionButton(BuildContext context, String label) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        minimumSize: const Size(double.infinity, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.black,
        elevation: 6,
      ),
      onPressed: () {},
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontFamily: 'Inter',
        ),
      ),
    ),
  );
}

TextButton createEventBotton(
    BuildContext context,
    TextEditingController eventNameController,
    TextEditingController eventDescriptionController,
    String eventDate,
    List<String> selectedCategories,
    List<File> eventImages,
    User userinfo,
    EventBloc eventBloc) {
  return TextButton.icon(
    icon: const Icon(Icons.system_update_alt_rounded),
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: ColorStyles.primaryBlue,
      minimumSize: const Size(double.infinity, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black,
      elevation: 6,
    ),
    onPressed: () {
      // Unfocus keyboard
      FocusManager.instance.primaryFocus?.unfocus();
      // Get event data
      String eventName = eventNameController.text.trim();
      String eventDescription = eventDescriptionController.text.trim();
      // Verify if data are not empty
      if (eventName.isNotEmpty &&
          eventDescription.isNotEmpty &&
          eventDate.isNotEmpty &&
          selectedCategories.isNotEmpty &&
          eventImages.isNotEmpty) {
        // Bloc event
        eventBloc.add(CreateEvent(
            name: eventName,
            description: eventDescription,
            date: eventDate,
            categories: selectedCategories,
            userID: userinfo.userinfo['pk'],
            images: eventImages));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar('No se permiten cambios vacios'),
        );
      }
    },
    label: const Text(
      'Guardar',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
    ),
  );
}
