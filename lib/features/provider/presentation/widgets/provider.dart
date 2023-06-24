import 'package:eventhub_app/features/provider/presentation/pages/provider_screen.dart';
import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';

Padding providerWidget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProviderScreen()));
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
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: Image.asset(Images.providerPlaceholder),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Proveedor',
                    style: TextStyle(
                      color: ColorStyles.primaryGrayBlue,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  const Text(
                    'Breve descripción o eslogan de la empresa, organización o proveedor',
                    style: TextStyle(
                      color: ColorStyles.primaryGrayBlue,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Inter',
                    ),
                  ),
                  providerCategoryLabel(),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Chip providerCategoryLabel() {
  return Chip(
    backgroundColor: ColorStyles.secondaryColor1,
    labelStyle: const TextStyle(
      color: ColorStyles.baseLightBlue,
      fontFamily: 'Inter',
      fontSize: 12,
    ),
    label: const Text('Categoria'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

Padding providerInfo(IconData icon, String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(
          icon,
          color: ColorStyles.primaryBlue,
          size: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            label,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: ColorStyles.primaryGrayBlue,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
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
        minimumSize: Size(MediaQuery.of(context).size.width * 0.33, 40),
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
