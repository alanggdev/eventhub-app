import 'package:flutter/material.dart';

import 'package:eventhub_app/keys.dart';
import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/provider/presentation/pages/provider_screen.dart';
import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/domain/entities/service.dart';

import 'package:eventhub_app/features/auth/domain/entities/user.dart';

Padding providerWidget(BuildContext context, Provider provider, User user) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProviderScreen(provider.providerId!, null, user)));
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
                aspectRatio: 32 / 9,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        provider.companyDescription,
                        style: const TextStyle(
                          color: ColorStyles.primaryGrayBlue,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 8,
                        children: provider.categories.map((category) {
                          return providerCategoryLabel(category);
                        }).toList(),
                        //
                      ),
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
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(
          icon,
          color: ColorStyles.primaryBlue,
          size: 20,
        ),
        Expanded(
          child: Padding(
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
        ),
      ],
    ),
  );
}

Padding providerDaysInfo(IconData icon, List<dynamic> daysAvailability,
    String day, List<dynamic> hoursAvailability) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Icon(
          icon,
          color: ColorStyles.primaryBlue,
          size: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 6),
          child: Text(
            daysAvailability.contains(day) ? 'Disponible' : 'No disponible',
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: ColorStyles.primaryGrayBlue,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ),
        SizedBox(
          height: 25,
          width: 25,
          child: PopupMenuButton(
            icon: const Icon(
              Icons.expand_more,
              color: ColorStyles.primaryGrayBlue,
            ),
            padding: const EdgeInsets.only(bottom: 10),
            onSelected: (value) {},
            itemBuilder: (BuildContext context) {
              return daysAvailability.map((day) {
                return PopupMenuItem(
                  value: day,
                  child: Text(day),
                );
              }).toList();
            },
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              'De ${hoursAvailability[0]} a ${hoursAvailability[1]}',
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: ColorStyles.primaryGrayBlue,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Container providerImage(dynamic image) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 0,
          blurRadius: 5,
          offset: const Offset(0, 1),
        ),
      ],
    ),
    child: AspectRatio(
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
    ),
  );
}

Column providerServiceWidget(BuildContext context, Service service) {
  return Column(
    children: [
      Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Card(
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Text(
                              service.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: ColorStyles.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 100,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    service.description,
                                    style: const TextStyle(
                                      color: ColorStyles.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: SizedBox(
                                      height: 50,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10),
                                        child: Wrap(
                                          spacing: 6,
                                          children:
                                              service.tags.map((option) {
                                            return Chip(
                                              backgroundColor:
                                                  ColorStyles.secondaryColor3,
                                              labelStyle: const TextStyle(
                                                color: ColorStyles.black,
                                                fontFamily: 'Inter',
                                              ),
                                              label: Text(option),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: service.images == null ?
                        Image.network(
                          '$serverURL${service.imagePaths?[0]}',
                          fit: BoxFit.cover,
                          alignment: FractionalOffset.center,
                        ) :
                        Image.file(
                          service.images![0],
                          fit: BoxFit.cover,
                          alignment: FractionalOffset.center,
                        ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
