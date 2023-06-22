import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';

Padding textFieldForm(BuildContext context, IconData icon, String label,
    TextEditingController fieldContoller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: ColorStyles.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 3)
            ),
          ],
        ),
        child: TextField(
          controller: fieldContoller,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: ColorStyles.secondaryColor3,
            ),
            hintText: label,
            hintStyle: const TextStyle(
              color: ColorStyles.secondaryColor3,
              fontFamily: 'Inter',
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    ),
  );
}

Padding textFieldFormCompany(BuildContext context, String label,
    TextEditingController fieldContoller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: ColorStyles.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 3)
            ),
          ],
        ),
        child: TextField(
          controller: fieldContoller,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: const TextStyle(
              color: ColorStyles.secondaryColor3,
              fontFamily: 'Inter',
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    ),
  );
}
