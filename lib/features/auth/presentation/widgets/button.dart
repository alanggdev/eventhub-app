import 'package:eventhub_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/auth/presentation/pages/sign_in_screen.dart';
import 'package:eventhub_app/features/auth/presentation/pages/create_company_screen.dart';
import 'package:eventhub_app/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/alerts.dart';

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

TextButton formButtonSignUp(
    BuildContext context,
    UserTypes? userType,
    TextEditingController usernameController,
    TextEditingController fullnameController,
    TextEditingController emailController,
    TextEditingController passController,
    TextEditingController passConfirmController,
    AuthBloc authBloc) {
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
      if (userType == UserTypes.normal) {
        // Unfocus keyboard
        FocusManager.instance.primaryFocus?.unfocus();
        // Get register data
        String username = usernameController.text.trim();
        String fullname = fullnameController.text.trim();
        String email = emailController.text.trim();
        String pass = passController.text.trim();
        String passConfirm = passConfirmController.text.trim();
        bool isprovider = false;
        // Verify if credentials are not empty
        if (username.isNotEmpty &&
            fullname.isNotEmpty &&
            email.isNotEmpty &&
            pass.isNotEmpty &&
            passConfirm.isNotEmpty) {
          // Verify if password fields
          if (pass == passConfirm) {
            authBloc.add(CreateUser(
                username: username,
                fullname: fullname,
                email: email,
                password: pass,
                isprovider: isprovider));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              snackBar('Verifique la contraseña'),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar('No se permiten cambios vacios'),
          );
        }
      } else if (userType == UserTypes.supplier) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CreateCompanyScreen()),
        );
      }
    },
    child: Text(
      userType == UserTypes.normal ? 'Crear cuenta' : 'Continuar',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
    ),
  );
}

TextButton formButtonSignIn(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passController,
    AuthBloc authBloc) {
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
      // Unfocus keyboard
      FocusManager.instance.primaryFocus?.unfocus();
      // Verify login credentials
      String email = emailController.text.trim();
      String pass = passController.text.trim();
      // Verify if credentials are not empty
      if (email.isNotEmpty && pass.isNotEmpty) {
        authBloc.add(SignInUser(email: email, password: pass));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar('No se permiten cambios vacios'),
        );
      }
    },
    child: const Text(
      'Iniciar sesión',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
    ),
  );
}

TextButton formButtonNextCompany(BuildContext context) {
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
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AddInfoCompanyScreen()));
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

TextButton formButtonCreateCompany(BuildContext context) {
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
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => const HomeScreen()),
      //     (route) => false);
    },
    child: const Text(
      'Registrar empresa',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
    ),
  );
}
