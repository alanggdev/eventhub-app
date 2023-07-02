import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/provider/domain/entities/service.dart';

Padding serviceWidget(BuildContext context, Service service) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: Container(
      height: 160,
      decoration: BoxDecoration(
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
          children: [
            Center(
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
                              Text(
                                service.name,
                                style: const TextStyle(
                                  color: ColorStyles.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              Text(
                                service.description,
                                style: const TextStyle(
                                  color: ColorStyles.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Wrap(
                                  spacing: 6,
                                  children: service.tags.map((option) {
                                    return Chip(
                                      backgroundColor:
                                          ColorStyles.secondaryColor3,
                                      labelStyle: const TextStyle(
                                        color: ColorStyles.black,
                                        fontFamily: 'Inter',
                                      ),
                                      label: Text(option),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    );
                                  }).toList(),
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
                          child: Image.file(
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
          ],
        ),
      ),
    ),
  );
}
