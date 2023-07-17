import 'package:flutter/material.dart';

class ColorStyles {
  static const Color baseLightBlue = Color(0xffF8F4FB);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  static const Color primaryBlue = Color(0xff4F5496);
  static const Color primaryDarkGray = Color(0xff303146);
  static const Color primaryGrayBlue = Color(0xff606172);
  static const Color primaryDarkBlue = Color(0xff404374);

  static const Color secondaryColor1 = Color(0xff746C96);
  static const Color secondaryColor2 = Color(0xff857CAB);
  static const Color secondaryColor3 = Color(0xffB8B0E1);
  static const Color secondaryColor4 = Color(0xffBCBCBC);

  static const Color textPrimary1 = Color(0xff4F5496);
  static const Color textPrimary2 = Color(0xff606172);
  static const Color textSecondary1 = Color(0xff746C96);
  static const Color textSecondary2 = Color(0xff857CAB);
  static const Color textSecondary3 = Color(0xffB8B0E1);

  static const Color logoBlue = Color(0xff4F5496);
  static const Color logoLightBlue = Color.fromARGB(127, 248, 244, 251);
  static const Color logoLightGreenGray = Color.fromARGB(127, 234, 172, 178);

  static const Color warningCancel = Color(0xff4D4A4A);
}

class Images {
  static const String logoURL = 'assets/images/logo.png';
  static const String error = 'assets/images/error.png';

  static const String welcomeAuth = 'assets/images/auth/welcome.png';
  static const String emptyImage = 'assets/images/auth/empty_image.png';
  static const String profilePlaceholder = 'assets/images/auth/profile_placeholder.png';
  static const String companyPlaceholder = 'assets/images/auth/company_placeholder.png';
  
  static const String emptyEvents = 'assets/images/event/empty.png';
  static const String eventPlaceholder = 'assets/images/event/placeholder_event.png';

  static const String categoryPlaceholder = 'assets/images/provider/category_placeholder.png';
  static const String providerPlaceholder = 'assets/images/provider/provider_placeholder.png';
  static const String providerDetailPlaceholder = 'assets/images/provider/provider_placeholder_detail.png';

  static const String emptychat = 'assets/images/chat/emptyChat.png';
}

class CustomIcons {
  static const String homeFilled = 'assets/icons/home_filled.png';
  static const String homeOutlined = 'assets/icons/home_outlined.png';
  static const String providersFilled = 'assets/icons/providers_filled.png';
  static const String providersOutlined = 'assets/icons/providers_outlined.png';
  static const String messagesFilled = 'assets/icons/messages_filled.png';
  static const String messagesOutlined = 'assets/icons/messages_outlined.png';
  static const String notificationsFilled = 'assets/icons/notifications_filled.png';
  static const String notificationsOutlined = 'assets/icons/notifications_outlined.png';
}

Padding errorWidget(BuildContext context, String error) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 30),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Images.error,
          width: MediaQuery.of(context).size.width * 0.8,
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Text(
            error,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorStyles.primaryGrayBlue,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    ),
  );
}

Padding emptyWidget(BuildContext context, String label, String image) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 30),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: MediaQuery.of(context).size.width * 0.8,
        ),
        Text(
          label,
          style: const TextStyle(
            color: ColorStyles.primaryGrayBlue,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
      ],
    ),
  );
}

Stack loading(BuildContext context) {
  return Stack(
    children: [
      Container(
        color: Colors.black54,
      ),
      Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: 175,
          decoration: BoxDecoration(
            color: ColorStyles.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 4,
                  offset: const Offset(0, 3)),
            ],
          ),
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Padding(
            padding: EdgeInsets.all(15),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
          Text(
            'Espere un momento...',
            style: TextStyle(
                // color: Colors.black,
                color: ColorStyles.textPrimary2,
                decoration: TextDecoration.none,
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    ],
  );
}
