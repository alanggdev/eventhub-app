import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/provider/domain/entities/service.dart';

Padding serviceWidget(BuildContext context, Service service) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
    child: SizedBox(
      height: 150,
      child: Column(
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
                                  style: const TextStyle(
                                    color: ColorStyles.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 80,
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
          ),
        ],
      ),
    ),
  );
}
