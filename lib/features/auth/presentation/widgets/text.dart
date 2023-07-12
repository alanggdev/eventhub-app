import 'package:flutter/material.dart';
import 'package:eventhub_app/assets.dart';

Padding textInterW500(String label) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        fontFamily: 'Inter',
        color: ColorStyles.primaryGrayBlue,
      ),
    ),
  );
}

Text textInterW600(String label) {
  return Text(
    label,
    style: const TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      fontFamily: 'Inter',
      color: ColorStyles.primaryGrayBlue,
    ),
  );
}
