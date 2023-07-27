import 'package:flutter/material.dart';
import 'dart:io';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/event/presentation/widgets/alerts.dart';
import 'package:eventhub_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Padding eventOptionButton(
    BuildContext context, String label, int eventid, EventBloc eventBloc) {
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
      onPressed: () {
        Widget cancelButton = TextButton(
          child: const Text("Cancelar"),
          onPressed: () {
            Navigator.pop(context);
          },
        );
        Widget continueButton = TextButton(
          child: const Text("Eliminar"),
          onPressed: () {
            Navigator.pop(context);
            eventBloc.add(DeleteUserEvent(eventid: eventid));
          },
        );
        // set up the AlertDialog
        AlertDialog alert = AlertDialog(
          title: const Text("Eliminar contenido"),
          content: const Text("¿Está seguro de eliminar este evento?"),
          actions: [
            cancelButton,
            continueButton,
          ],
        );
        // show the dialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          },
        );
      },
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
    icon: const Icon(Icons.system_update_alt_rounded, size: 22),
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: ColorStyles.primaryBlue,
      minimumSize: const Size(double.infinity, 45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.grey.withOpacity(0.5),
      elevation: 3,
    ),
    onPressed: () async {
      // Unfocus keyboard
      FocusManager.instance.primaryFocus?.unfocus();
      // Get event data
      String eventName = eventNameController.text.trim();
      String eventDescription = eventDescriptionController.text.trim();
      // Verify if data are not empty
      if (eventName.isNotEmpty &&
          eventDescription.isNotEmpty &&
          eventDate.isNotEmpty && eventDate != 'Seleccionar fecha' &&
          selectedCategories.isNotEmpty &&
          eventImages.isNotEmpty) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('type', 'Normal');
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
      'Solo guardar',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
    ),
  );
}

TextButton createAndViewEventBotton(
    BuildContext context,
    TextEditingController eventNameController,
    TextEditingController eventDescriptionController,
    String eventDate,
    List<String> selectedCategories,
    List<File> eventImages,
    User userinfo,
    EventBloc eventBloc) {
  return TextButton.icon(
    icon: const Icon(Icons.system_update_alt_rounded, size: 22),
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: ColorStyles.primaryBlue,
      minimumSize: const Size(double.infinity, 45),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.grey.withOpacity(0.5),
      elevation: 3,
    ),
    onPressed: () async {
      // Unfocus keyboard
      FocusManager.instance.primaryFocus?.unfocus();
      // Get event data
      String eventName = eventNameController.text.trim();
      String eventDescription = eventDescriptionController.text.trim();
      // Verify if data are not empty
      if (eventName.isNotEmpty &&
          eventDescription.isNotEmpty &&
          eventDate.isNotEmpty && eventDate != 'Seleccionar fecha' &&
          selectedCategories.isNotEmpty &&
          eventImages.isNotEmpty) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('type', 'Suggestions');
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
      'Guardar y mostrar empresas',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
      ),
    ),
  );
}