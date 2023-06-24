import 'package:eventhub_app/assets.dart';
import 'package:flutter/material.dart';

Padding eventWidget() {
  return Padding(
    padding: const EdgeInsets.all(15),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.asset('assets/images/event/test_event.png'),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
