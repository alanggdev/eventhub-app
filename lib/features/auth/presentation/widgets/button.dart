import 'package:eventhub_app/features/auth/presentation/pages/sign_in_screnn.dart';
import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Padding authButton(BuildContext context, String buttonType) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: TextButton.icon(
      icon: buttonType == 'Correo'
          ? const Icon(Icons.email)
          : const FaIcon(
              FontAwesomeIcons.google,
              color: ColorStyles.textPrimary2,
            ),
      style: OutlinedButton.styleFrom(
        foregroundColor: ColorStyles.white,
        backgroundColor: buttonType == 'Correo'
            ? ColorStyles.primaryBlue
            : ColorStyles.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: ColorStyles.black,
        elevation: 6,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        );
      },
      label: Text(
        'Ingresar con $buttonType',
        style: TextStyle(
          color: buttonType == 'Correo'
              ? ColorStyles.white
              : ColorStyles.textPrimary2,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
      ),
    ),
  );
}

TextButton formButton(BuildContext context, String label, String destiny) {
  return TextButton(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: ColorStyles.primaryBlue,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black,
      elevation: 6,
    ),
    onPressed: () {
      Navigator.pushNamed(context, destiny);
    },
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
    ),
  );
}
