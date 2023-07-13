import 'package:eventhub_app/assets.dart';
import 'package:flutter/material.dart';

Stack loadingChatWidget(BuildContext context) {
  return Stack(
    children: [
      Container(
        color: ColorStyles.baseLightBlue.withOpacity(0.01),
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
                decoration: TextDecoration.none,
                color: ColorStyles.textPrimary2,
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    ],
  );
}