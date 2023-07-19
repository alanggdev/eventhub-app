import 'package:eventhub_app/assets.dart';
import 'package:flutter/material.dart';

SnackBar snackBar(String alert) {
  return SnackBar(
    duration: const Duration(seconds: 3),
    content: Text(
      alert,
    ),
    backgroundColor: Colors.red,
  );
}

Stack loadingWidget(BuildContext context) {
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

Builder errorAlert(BuildContext context, String error) {
  return Builder(
    builder: (context) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              error,
              style: const TextStyle(
                decoration: TextDecoration.none,
              ),
            ),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      });
      return Container();
    },
  );
}

Future<dynamic> tooltip(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Center(
        child: Stack(
          children: <Widget>[
            Container(
              width: 320,
              height: 170,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 0.0,
                      offset: Offset(0.0, 0.0),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  height: 140,
                  width: 320,
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      RichText(
                        text: const TextSpan(
                          text: "Elige ",
                          style: TextStyle(
                              color: ColorStyles.textPrimary2,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Usuario Estándar ",
                              style: TextStyle(
                                  color: ColorStyles.textSecondary2,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text:
                                  "si solo quieres llevar el control de tus eventos.",
                              style: TextStyle(
                                  color: ColorStyles.textPrimary2,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      RichText(
                        text: const TextSpan(
                          text: "Elige ",
                          style: TextStyle(
                              color: ColorStyles.textPrimary2,
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500),
                          children: <TextSpan>[
                            TextSpan(
                              text: "Organizador/Proveedor ",
                              style: TextStyle(
                                  color: ColorStyles.textSecondary2,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600),
                            ),
                            TextSpan(
                              text:
                                  "si eres una empresa u organizador independiente que ofrece servicios o productos para eventos. Aún podrás crear y gestionar tus eventos, y los usuarios estándar podrán contactarte.",
                              style: TextStyle(
                                  color: ColorStyles.textPrimary2,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.close, color: ColorStyles.primaryGrayBlue),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
