import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/auth/presentation/pages/login/sign_in_screen.dart';
import 'package:eventhub_app/features/auth/presentation/pages/register/provider/create_company_screen.dart';
import 'package:eventhub_app/features/auth/presentation/pages/register/provider/add_info_company_screen.dart';
import 'package:eventhub_app/features/auth/presentation/pages/register/user/google_sign_up_screen.dart';
import 'package:eventhub_app/features/auth/presentation/pages/register/user/sign_up_screen.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/alerts.dart';
import 'package:eventhub_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_provider.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';

import 'package:eventhub_app/features/provider/domain/entities/service.dart';

Padding authButton(
    BuildContext context, String buttonType, AuthBloc? authBloc) {
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
        elevation: 3,
      ),
      onPressed: () async {
        // final googleSignIn = GoogleSignIn();
        if (buttonType == 'Correo') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
          );
          // googleSignIn.signOut();
        } else {
          authBloc!.add(GoogleLogIn());
        }
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
    AuthBloc authBloc,
    bool termsAndConditions) {
  return TextButton(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: termsAndConditions ? ColorStyles.primaryBlue : ColorStyles.primaryGrayBlue,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black,
      elevation: 3,
    ),
    onPressed: () {
      // Unfocus keyboard
      FocusManager.instance.primaryFocus?.unfocus();
      if (termsAndConditions) {
        // Get register data
        String username = usernameController.text.trim();
        String fullname = fullnameController.text.trim();
        String email = emailController.text.trim();
        String pass = passController.text.trim();
        String passConfirm = passConfirmController.text.trim();
        // Verify if credentials are not empty
        if (username.isNotEmpty &&
            fullname.isNotEmpty &&
            email.isNotEmpty &&
            pass.isNotEmpty &&
            passConfirm.isNotEmpty) {
          // Verify if password fields
          if (pass == passConfirm) {
            // User registration
            if (userType == UserTypes.normal) {
              // data
              bool isprovider = false;
              authBloc.add(CreateUser(
                  username: username,
                  fullname: fullname,
                  email: email,
                  password: pass,
                  isprovider: isprovider));
            } else if (userType == UserTypes.supplier) {
              // company registration
              bool isprovider = true;
              RegisterUser registerUserData = RegisterUser(
                  username: username,
                  fullname: fullname,
                  email: email,
                  password: pass,
                  isprovider: isprovider);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateCompanyScreen(registerUserData, null)),
              );
            }
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
      elevation: 3,
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

TextButton formButtonSignUpGoogle(BuildContext context, User userData,
  AccountTypes? accountType, TextEditingController fullnameController,
    AuthBloc authBloc, bool termsAndConditions) {
  return TextButton(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: termsAndConditions ? ColorStyles.primaryBlue : ColorStyles.primaryGrayBlue,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black,
      elevation: 3,
    ),
    onPressed: () {
      // Unfocus keyboard
      FocusManager.instance.primaryFocus?.unfocus();
      if (termsAndConditions) {
        // Get register data
        String fullname = fullnameController.text.trim();
        // Verify if credentials are not empty
        if (fullname.isNotEmpty) {
            // User registration
            if (accountType == AccountTypes.normal) {
              // data
              bool isprovider = false;
              // go to update profile
              RegisterUser registerUser = RegisterUser(username: 'GoogleAccount', fullname: fullname, email: 'GoogleAccount', password: 'GoogleAccount', isprovider: isprovider);
              authBloc.add(CompleteGoogleLogIn(userData: userData, registerData: registerUser));
              
            } else if (accountType == AccountTypes.supplier) {
              // company registration
              bool isprovider = true;
              RegisterUser registerUser = RegisterUser(username: 'GoogleAccount', fullname: fullname, email: 'GoogleAccount', password: 'GoogleAccount', isprovider: isprovider);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateCompanyScreen(registerUser, userData)),
              );
            }
          
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar('No se permiten cambios vacios'),
          );
        }
      }
      
    },
    child: Text(
      accountType == AccountTypes.normal ? 'Crear cuenta' : 'Continuar',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
    ),
  );
}

TextButton formButtonNextCompany(
  BuildContext context,
  RegisterUser registerUserData,
  TextEditingController companyNameController,
  TextEditingController companyDescriptionController,
  TextEditingController companyPhoneController,
  TextEditingController companyEmailController,
  TextEditingController companyAddressController,
  List<String> selectedDays,
  String openTime,
  String closeTime,
  List<String> companyLocation,
  User? userData
) {
  return TextButton(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: ColorStyles.primaryBlue,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black,
      elevation: 3,
    ),
    onPressed: () {
      FocusManager.instance.primaryFocus?.unfocus();

      String companyName = companyNameController.text.trim();
      String companyDescription = companyDescriptionController.text.trim();
      String companyPhone = companyPhoneController.text.trim();
      String companyEmail = companyEmailController.text.trim();
      String companyAddress = companyAddressController.text.trim();

      if (companyName.isNotEmpty &&
          companyDescription.isNotEmpty &&
          companyPhone.isNotEmpty &&
          companyEmail.isNotEmpty &&
          companyAddress.isNotEmpty &&
          selectedDays.isNotEmpty &&
          openTime != 'Seleccionar' &&
          closeTime != 'Seleccionar') {
        RegisterProvider registerProviderData = RegisterProvider(
            companyName: companyName,
            companyDescription: companyDescription,
            companyPhone: companyPhone,
            companyEmail: companyEmail,
            companyAddress: companyAddress,
            companySelectedDays: selectedDays,
            openTime: openTime,
            closeTime: closeTime,
            companyLocation: companyLocation);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddInfoCompanyScreen(
                  registerUserData, registerProviderData, null, null, null, userData),
              settings: const RouteSettings(name: '/addinfocompany'),
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar('No se permiten cambios vacios'),
        );
      }
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

TextButton formButtonCreateCompany(
    BuildContext context,
    RegisterUser registerUserData,
    RegisterProvider registerProviderData,
    List<String> selectedCategories,
    List<File> companyImages,
    List<Service> services,
    AuthBloc authBloc,
    User? userData) {
  return TextButton(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: ColorStyles.primaryBlue,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black,
      elevation: 3,
    ),
    onPressed: () {
      if (selectedCategories.isNotEmpty && companyImages.isNotEmpty && services.isNotEmpty) {
        registerProviderData.categoriesList = selectedCategories;
        registerProviderData.imagesList = companyImages;
        registerProviderData.services = services;

        if (userData == null) {
          authBloc.add(CreateProvider(registerProviderData: registerProviderData, registerUserData: registerUserData));
        } else {
          authBloc.add(CompleteProviderGoogleLogIn(userData: userData, registerData: registerUserData, registerProviderData: registerProviderData));
        }
        
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar('No se permiten cambios vacios'),
        );
      }
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
