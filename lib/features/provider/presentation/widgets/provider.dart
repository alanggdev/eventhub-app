import 'package:flutter/material.dart';

import 'package:eventhub_app/keys.dart';
import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/presentation/pages/provider_screen.dart';

Padding providerWidget(BuildContext context, Provider provider) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProviderScreen(provider)));
      },
      child: Container(
        width: double.infinity,
        height: 245,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 64 / 25,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: FadeInImage(
                    fit: BoxFit.fitWidth,
                    alignment: FractionalOffset.center,
                    image: NetworkImage('$serverURL${provider.urlImages[0]}'),
                    placeholder: const AssetImage(Images.eventPlaceholder),
                    imageErrorBuilder: (context, error, stackTrace) {
                      return const Center(child: Text('provider image'));
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      provider.companyName,
                      style: const TextStyle(
                        color: ColorStyles.primaryGrayBlue,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Text(
                      provider.companyDescription,
                      style: const TextStyle(
                        color: ColorStyles.primaryGrayBlue,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Inter',
                      ),
                    ),
                    Wrap(
                      spacing: 8,
                      children: provider.categories.map((category) {
                        return providerCategoryLabel(category);
                      }).toList(),
                      //
                    ),
                    // children: [
                    //   providerCategoryLabel(),
                    // ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Chip providerCategoryLabel(dynamic category) {
  return Chip(
    backgroundColor: ColorStyles.secondaryColor1,
    labelStyle: const TextStyle(
      color: ColorStyles.baseLightBlue,
      fontFamily: 'Inter',
      fontSize: 12,
    ),
    label: Text(category),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );
}

Padding providerInfo(IconData icon, String label) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(
          icon,
          color: ColorStyles.primaryBlue,
          size: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            label,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: ColorStyles.primaryGrayBlue,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    ),
  );
}

Padding providerOptionButton(BuildContext context, String label) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: ColorStyles.primaryBlue,
        minimumSize: Size(MediaQuery.of(context).size.width * 0.33, 40),
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

AspectRatio providerImage(dynamic image) {
  return AspectRatio(
    aspectRatio: 64 / 25,
    child: Padding(
      padding: const EdgeInsets.all(4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: FadeInImage(
          fit: BoxFit.fitWidth,
          alignment: FractionalOffset.center,
          image: NetworkImage('$serverURL$image'),
          placeholder: const AssetImage(Images.providerDetailPlaceholder),
          imageErrorBuilder: (context, error, stackTrace) {
            return const Center(child: Text('event image'));
          },
        ),
      ),
    ),
  );
}
