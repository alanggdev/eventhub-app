import 'dart:io';

import 'package:eventhub_app/features/provider/presentation/bloc/provider_bloc.dart';
import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/presentation/pages/edit/edit_categories_screen.dart';
import 'package:eventhub_app/features/provider/presentation/pages/edit/edit_information_screen.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/alerts.dart';

TextButton providerNextPage(
  BuildContext context,
  Provider providerData,
  TextEditingController companyNameController,
  TextEditingController companyDescriptionController,
  TextEditingController companyPhoneController,
  TextEditingController companyEmailController,
  TextEditingController companyAddressController,
  List<String> selectedDays,
  String openTime,
  String closeTime,
) {
  return TextButton(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: ColorStyles.primaryBlue,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black,
      elevation: 3,
    ),
    onPressed: () {
      FocusManager.instance.primaryFocus?.unfocus();

      String companyName = companyNameController.text.trim();
      String companyDescription = companyDescriptionController.text.trim();
      String companyPhone = companyPhoneController.text.trim();
      String companyEmail = companyEmailController.text.trim();
      String companyAddress = companyAddressController.text.trim();

      if (companyName.isNotEmpty && companyDescription.isNotEmpty &&
          companyPhone.isNotEmpty && companyEmail.isNotEmpty &&
          companyAddress.isNotEmpty && selectedDays.isNotEmpty &&
          openTime != 'Seleccionar' && closeTime != 'Seleccionar') {

        providerData.companyName = companyName;
        providerData.companyDescription = companyDescription;
        providerData.companyPhone = companyPhone;
        providerData.companyEmail = companyEmail;
        providerData.companyAddress = companyAddress;
        providerData.daysAvailability = selectedDays;
        providerData.hoursAvailability = [openTime,closeTime];
        
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditCategoriesScreen(providerData, null, null, null)
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar('No se permiten cambios vacios'),
        );
      }
    },
    child: const Text(
      'Siguiente',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
    ),
  );
}

TextButton saveProviderData(
    BuildContext context,
    Provider providerData,
    List<String> selectedCategories,
    List<File> companyImages,
    List<String> imagesPreLoaded,
    ProviderBloc providerBloc) {
  return TextButton(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: ColorStyles.primaryBlue,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black,
      elevation: 3,
    ),
    onPressed: () {
      if (selectedCategories.isNotEmpty && companyImages.isNotEmpty || imagesPreLoaded.isNotEmpty) {
        providerData.categories = selectedCategories;
        providerData.filesToUpload = companyImages;
        providerData.urlImages = imagesPreLoaded;
        providerBloc.add(UpdateProviderData(providerData: providerData));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar('No se permiten cambios vacios'),
        );
      }
    },
    child: const Text(
      'Guardar datos',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
    ),
  );
}

Padding providerOptionButton(BuildContext context, String label) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: ColorStyles.primaryBlue,
        minimumSize: const Size(150, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.black,
        elevation: 6,
      ),
      onPressed: () {},
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 6),
            child: Icon(
              label == 'Contactar' ? Icons.message : Icons.event,
              size: 24,
            ),
          )
        ],
      ),
    ),
  );
}

Padding providerEditButton(BuildContext context, String label, Provider providerData) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    child: TextButton(
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
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditInformationScreen(providerData),
            ));
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