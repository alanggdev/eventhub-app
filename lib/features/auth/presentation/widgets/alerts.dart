import 'package:flutter/material.dart';

SnackBar snackBar(String alert) {
  return SnackBar(
    duration: const Duration(seconds: 3),
    content: Text(
      alert,
    ),
    backgroundColor: Colors.red,
  );
}
