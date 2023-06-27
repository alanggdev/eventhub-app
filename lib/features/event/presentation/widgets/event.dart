import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/event/presentation/pages/event_screen.dart';

Padding eventWidget(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const EventScreen()));
      },
      child: Container(
        width: double.infinity,
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
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Boda Test',
                    style: TextStyle(
                      color: ColorStyles.primaryGrayBlue,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                  Text(
                    '12/06/23',
                    style: TextStyle(
                      color: ColorStyles.primaryGrayBlue,
                      fontSize: 12,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AspectRatio(
                  aspectRatio: 64 / 25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: const FadeInImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.center,
                      image: NetworkImage(
                          'http://54.157.159.108/uploads/1687838498070.jpg'),
                      placeholder: AssetImage(Images.eventPlaceholder),
                    ),
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10),
              //   child: ClipRRect(
              //     borderRadius: BorderRadius.circular(5),
              //     child: Image.network('http://54.157.159.108/uploads/1687838498070.jpg')//Image.asset('assets/images/event/test_event.png'),
              //   ),
              // )
            ],
          ),
        ),
      ),
    ),
  );
}

Chip eventCategoryLabel() {
  return Chip(
    backgroundColor: ColorStyles.secondaryColor1,
    labelStyle: const TextStyle(
      color: ColorStyles.baseLightBlue,
      fontFamily: 'Inter',
      fontSize: 12,
    ),
    label: const Text('Categoria'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );
}
