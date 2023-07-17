import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';

Padding textField(BuildContext context, IconData icon, String label, TextEditingController? fieldContoller, TextInputType textInputType) {
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
                color: Colors.grey.withOpacity(0.125),
                blurRadius: 4,
                offset: const Offset(0, 0.35)),
            ],
          ),
        ),
        TextField(
          controller: fieldContoller,
          keyboardType: textInputType,
          enabled: fieldContoller != null ? true : false,
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

Padding textFieldMaxLength(BuildContext context, IconData icon, String label, TextEditingController? fieldContoller, int maxLength) {
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

Padding textFieldPass(BuildContext context, IconData icon, String label, TextEditingController? fieldContoller,
    bool hidePass, Function(bool state) changePassVisibility) {
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
                color: Colors.grey.withOpacity(0.125),
                blurRadius: 4,
                offset: const Offset(0, 0.35)),
            ],
          ),
        ),
        TextField(
          controller: fieldContoller,
          obscureText: hidePass,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: ColorStyles.secondaryColor3,
            ),
            suffixIcon: GestureDetector(
              onTap:  () {
                changePassVisibility(!hidePass);
              },
              child: Icon(
                hidePass ? Icons.visibility : Icons.visibility_off,
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

Padding textFieldLong(BuildContext context, IconData icon, String label, TextEditingController? fieldContoller, int maxLength) {
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
