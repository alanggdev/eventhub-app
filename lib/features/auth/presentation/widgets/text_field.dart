import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';

Padding textField(BuildContext context, IconData icon, String label, TextEditingController fieldContoller, TextInputType textInputType) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Stack(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  blurRadius: 5,
                  offset: const Offset(0, 1)),
            ],
          ),
        ),
        TextField(
          controller: fieldContoller,
          keyboardType: textInputType,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: ColorStyles.secondaryColor3,
            ),
            filled: true,
            fillColor: ColorStyles.white,
            hintText: label,
            counterStyle: const TextStyle(color: ColorStyles.secondaryColor3),
            hintStyle: const TextStyle(
              color: ColorStyles.secondaryColor3,
              fontFamily: 'Inter',
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    ),
  );
}

Padding textFieldMaxLength(BuildContext context, IconData icon, String label, TextEditingController fieldContoller, int maxLength) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    child: Stack(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  blurRadius: 5,
                  offset: const Offset(0, 1)),
            ],
          ),
        ),
        TextField(
          controller: fieldContoller,
          maxLength: maxLength,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: ColorStyles.secondaryColor3,
            ),
            filled: true,
            fillColor: ColorStyles.white,
            hintText: label,
            counterStyle: const TextStyle(color: ColorStyles.secondaryColor3),
            hintStyle: const TextStyle(
              color: ColorStyles.secondaryColor3,
              fontFamily: 'Inter',
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    ),
  );
}

Padding textFieldPass(BuildContext context, IconData icon, String label, TextEditingController fieldContoller) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Stack(
      children: [
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  blurRadius: 5,
                  offset: const Offset(0, 1)),
            ],
          ),
        ),
        TextField(
          controller: fieldContoller,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: ColorStyles.secondaryColor3,
            ),
            suffixIcon: GestureDetector(
              onTap:  () {},
              child: const Icon(
                Icons.visibility,
                color: ColorStyles.secondaryColor3,
              ),
            ),
            filled: true,
            fillColor: ColorStyles.white,
            hintText: label,
            counterStyle: const TextStyle(color: ColorStyles.secondaryColor3),
            hintStyle: const TextStyle(
              color: ColorStyles.secondaryColor3,
              fontFamily: 'Inter',
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    ),
  );
}

Padding textFieldLong(BuildContext context, IconData icon, String label, TextEditingController fieldContoller, int maxLength) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
    child: Stack(
      children: [
        Container(
          height: 123,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  blurRadius: 5,
                  offset: const Offset(0, 1)),
            ],
          ),
        ),
        TextField(
          controller: fieldContoller,
          maxLength: maxLength,
          maxLines: 6,
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 75),
              child: Icon(
                icon,
                color: ColorStyles.secondaryColor3,
              ),
            ),
            isDense: true,
            filled: true,
            fillColor: ColorStyles.white,
            hintText: label,
            counterStyle: const TextStyle(color: ColorStyles.secondaryColor3),
            hintStyle: const TextStyle(
              color: ColorStyles.secondaryColor3,
              fontFamily: 'Inter',
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    ),
  );
}
