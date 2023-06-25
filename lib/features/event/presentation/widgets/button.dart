import 'package:flutter/material.dart';

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