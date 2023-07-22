import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/notification/domain/entities/notification.dart' as notif;

Padding notificationWidget(BuildContext context, notif.Notification notification) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: GestureDetector(
      onTap: () {
        invitationWidget(context, notification);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorStyles.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              blurRadius: 5,
              offset: const Offset(0, 0.5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.notifications,
                    color: ColorStyles.secondaryColor2,
                    size: 24,
                  ),
                  // const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      notification.title.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        color: ColorStyles.secondaryColor1,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  notification.body.toString(),
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    color: ColorStyles.secondaryColor2,
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Future<void> invitationWidget(BuildContext context, notif.Notification notification) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        backgroundColor: const Color(0xffF3E7E7),
        content: Padding(
          padding: const EdgeInsets.all(8),
          child: SizedBox(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '¿Deseas aceptar la invitación como colaborador al evento: ${notification.eventName}? *',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: ColorStyles.black,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      fontSize: 18,
                    ),
                  ),
                ),
                const Text(
                  '* Al aceptar colaborar en un evento, tu empresa aparecerá en la sección de Empresas colaboradoras. Solo el creador del evento podrá ver esta información. Puedes deshacer la colaboración mas tarde.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: ColorStyles.warningCancel,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          Row(
            children: [
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextButton.icon(
                    icon: const Icon(Icons.close),
                    label: const Text('Rechazar'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      foregroundColor: Colors.white,
                      backgroundColor: ColorStyles.textSecondary3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.black,
                      elevation: 3,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextButton.icon(
                    icon: const Icon(Icons.done),
                    label: const Text('Aceptar'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      foregroundColor: Colors.white,
                      backgroundColor:
                          ColorStyles.primaryGrayBlue.withOpacity(0.75),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.black,
                      elevation: 3,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          )
        ],
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.only(bottom: 2),
        actionsPadding: const EdgeInsets.only(bottom: 15),
      );
    },
  );
}
