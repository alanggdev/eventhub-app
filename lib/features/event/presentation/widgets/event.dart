import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/keys.dart';

import 'package:eventhub_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:eventhub_app/features/event/presentation/pages/event_screen.dart';
import 'package:eventhub_app/features/event/domain/entities/event.dart';

import 'package:eventhub_app/features/auth/domain/entities/user.dart';

Padding eventWidget(BuildContext context, Event userEvent, User user) {
  return Padding(
    padding: const EdgeInsets.all(15),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventScreen(userEvent, user)));
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
                children: [
                  Flexible(
                    child: Text(
                      userEvent.name,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: ColorStyles.primaryGrayBlue,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                  Text(
                    userEvent.date,
                    style: const TextStyle(
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
                    child: FadeInImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.center,
                      image:
                          NetworkImage('$serverURL${userEvent.imagePaths![0]}'),
                      placeholder: const AssetImage(Images.eventPlaceholder),
                      imageErrorBuilder: (context, error, stackTrace) {
                        return const Center(child: Text('event image'));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Chip eventCategoryLabel(dynamic category) {
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

Container eventImage(dynamic image) {
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
            placeholder: const AssetImage(Images.eventPlaceholder),
            imageErrorBuilder: (context, error, stackTrace) {
              return const Center(child: Text('event image'));
            },
          ),
        ),
      ),
    ),
  );
}

PopupMenuButton<String> options(
    BuildContext context, int eventId, String type) {
  return PopupMenuButton(
    icon: const Icon(Icons.more_vert, color: ColorStyles.white, size: 28),
    onSelected: (value) {
      if (value == 'delete') {
        deleteEvent(context, eventId);
      } else if (value == 'leave') {
        leaveEvent(context, eventId);
      }
    },
    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      if (type == 'User')
        PopupMenuItem<String>(
          value: 'delete',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.delete, color: ColorStyles.primaryGrayBlue, size: 22),
              Text(
                'Eliminar servicio',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: ColorStyles.primaryGrayBlue,
                ),
              ),
            ],
          ),
        ),
      if (type == 'Provider')
        PopupMenuItem<String>(
          value: 'leave',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(Icons.logout, color: ColorStyles.primaryGrayBlue, size: 22),
              Text(
                'Dejar de colaborar',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  color: ColorStyles.primaryGrayBlue,
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

Future<void> deleteEvent(BuildContext context, int eventId) {
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
            height: 100,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          '¿Deseas eliminar este servicio?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorStyles.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                              fontSize: 20),
                        ),
                      ),
                      Text(
                        'Una vez eliminado la información del servicio no podrá ser recuperada.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorStyles.warningCancel,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                            fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.close),
            label: const Text('Cancelar'),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.3, 40),
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
          TextButton.icon(
            icon: const Icon(Icons.delete),
            label: const Text('Eliminar'),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.3, 40),
              foregroundColor: Colors.white,
              backgroundColor: ColorStyles.primaryGrayBlue.withOpacity(0.75),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadowColor: Colors.black,
              elevation: 3,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              context.read<EventBloc>().add(DeleteUserEvent(eventid: eventId));
            },
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.only(bottom: 2),
        actionsPadding: const EdgeInsets.only(bottom: 15),
      );
    },
  );
}

Future<void> leaveEvent(BuildContext context, int eventId) {
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
            height: 100,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          '¿Deseas dejar de colaborar en este evento?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorStyles.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                              fontSize: 20),
                        ),
                      ),
                      Text(
                        'Una vez hecho, podrás volver a colaborar mediante otra invitación.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorStyles.warningCancel,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                            fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.close),
            label: const Text('Cancelar'),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.3, 40),
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
          TextButton.icon(
            icon: const Icon(Icons.delete),
            label: const Text('Confirmar'),
            style: OutlinedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width * 0.3, 40),
              foregroundColor: Colors.white,
              backgroundColor: ColorStyles.primaryGrayBlue.withOpacity(0.75),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadowColor: Colors.black,
              elevation: 3,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              context.read<EventBloc>().add(RemoveProvider(eventid: eventId));
            },
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
        contentPadding: const EdgeInsets.only(bottom: 2),
        actionsPadding: const EdgeInsets.only(bottom: 15),
      );
    },
  );
}
