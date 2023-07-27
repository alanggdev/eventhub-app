import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';

Padding textFieldLong(BuildContext context, String label, TextEditingController? fieldContoller, int maxLength) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
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
                color: Colors.grey.withOpacity(0.125),
                blurRadius: 4,
                offset: const Offset(0, 0.35)),
            ],
          ),
        ),
        TextField(
          controller: fieldContoller,
          maxLength: maxLength,
          maxLines: 6,
          decoration: InputDecoration(
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

Padding textFieldMaxLength(BuildContext context, String label, TextEditingController? fieldContoller, int maxLength) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
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
                color: Colors.grey.withOpacity(0.125),
                blurRadius: 4,
                offset: const Offset(0, 0.35)),
            ],
          ),
        ),
        TextField(
          controller: fieldContoller,
          maxLength: maxLength,
          enabled: fieldContoller != null ? true : false,
          decoration: InputDecoration(
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