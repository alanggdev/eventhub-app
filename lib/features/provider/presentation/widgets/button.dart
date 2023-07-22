import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import 'package:eventhub_app/home.dart';
import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/domain/entities/service.dart';
import 'package:eventhub_app/features/provider/presentation/pages/edit/edit_categories_screen.dart';
import 'package:eventhub_app/features/provider/presentation/pages/edit/edit_information_screen.dart';
import 'package:eventhub_app/features/provider/presentation/pages/service_list_screen.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/alerts.dart';
import 'package:eventhub_app/features/provider/presentation/bloc/provider_bloc.dart';

import 'package:eventhub_app/features/auth/domain/entities/user.dart';

import 'package:eventhub_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:eventhub_app/features/event/domain/entities/event.dart';

// ignore: library_prefixes
import 'package:eventhub_app/features/notification/domain/entities/notification.dart' as Notif;
import 'package:eventhub_app/features/notification/presentation/bloc/notification_bloc.dart';

TextButton providerNextPage(
  BuildContext context,
  Provider providerData,
  TextEditingController companyNameController,
  TextEditingController companyDescriptionController,
  TextEditingController companyPhoneController,
  TextEditingController companyEmailController,
  TextEditingController companyAddressController,
  List<String> selectedDays,
  String openTime,
  String closeTime,
  User user,
  List<String> companyLocation
) {
  return TextButton(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: ColorStyles.primaryBlue,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black,
      elevation: 3,
    ),
    onPressed: () {
      FocusManager.instance.primaryFocus?.unfocus();

      String companyName = companyNameController.text.trim();
      String companyDescription = companyDescriptionController.text.trim();
      String companyPhone = companyPhoneController.text.trim();
      String companyEmail = companyEmailController.text.trim();
      String companyAddress = companyAddressController.text.trim();

      if (companyName.isNotEmpty && companyDescription.isNotEmpty &&
          companyPhone.isNotEmpty && companyEmail.isNotEmpty &&
          companyAddress.isNotEmpty && selectedDays.isNotEmpty &&
          openTime != 'Seleccionar' && closeTime != 'Seleccionar') {

        providerData.companyName = companyName;
        providerData.companyDescription = companyDescription;
        providerData.companyPhone = companyPhone;
        providerData.companyEmail = companyEmail;
        providerData.companyAddress = companyAddress;
        providerData.daysAvailability = selectedDays;
        providerData.hoursAvailability = [openTime,closeTime];
        providerData.location = companyLocation;
        
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditCategoriesScreen(providerData, null, null, null, user)
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar('No se permiten cambios vacios', Colors.red),
        );
      }
    },
    child: const Text(
      'Siguiente',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
    ),
  );
}

TextButton saveProviderData(
    BuildContext context,
    Provider providerData,
    List<String> selectedCategories,
    List<File> companyImages,
    List<String> imagesPreLoaded,
    ProviderBloc providerBloc) {
  return TextButton(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: ColorStyles.primaryBlue,
      minimumSize: const Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black,
      elevation: 3,
    ),
    onPressed: () {
      if (selectedCategories.isNotEmpty && companyImages.isNotEmpty || imagesPreLoaded.isNotEmpty) {
        providerData.categories = selectedCategories;
        providerData.filesToUpload = companyImages;
        providerData.urlImages = imagesPreLoaded;
        providerBloc.add(UpdateProviderData(providerData: providerData));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          snackBar('No se permiten cambios vacios', Colors.red),
        );
      }
    },
    child: const Text(
      'Guardar datos',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
      ),
    ),
  );
}

Padding providerInviteButton(BuildContext context, String label, User user, Provider provider) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextButton.icon(
      icon: const Icon(Icons.event, size: 22),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: ColorStyles.primaryBlue,
        minimumSize: const Size(double.infinity, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.black,
        elevation: 6,
      ),
      onPressed: () {
        context.read<EventBloc>().add(GetUserEvents(userid: user.userinfo['pk']));
        context.read<NotificationBloc>().add(SetInitialState());
        showDialog(
          context: context,
          builder: (context) {
            return BlocBuilder<EventBloc, EventState>(builder: (context, state) {
              return BlocBuilder<NotificationBloc, NotificationState>(builder: (context, notiState) {
                return AlertDialog(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  content: SizedBox(
                    height: 300,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'Eventos disponibles',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: ColorStyles.textSecondary1,
                              ),
                            ),
                          ),
                          if (state is GettingUserEvents || notiState is SendingNotification)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: CircularProgressIndicator(),
                                ),
                                Text(
                                  'Cargando...',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 18,
                                    color: ColorStyles.primaryBlue,
                                  ),
                                ),
                              ],
                            )
                          else if (state is UserEventGotten && notiState is! NotificationSent)
                            Column(
                              children: state.userEvents.map((event) {
                                return userEventWidget(context, event, user, provider);
                              },).toList(),
                            )
                          else if (state is NotifError)
                            const Text(
                              'No se pudo invitar al evento, intenta más tarde.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 18,
                                color: ColorStyles.primaryBlue,
                              ),
                            )
                          else if (notiState is NotificationSent)
                            FutureBuilder(
                              future: Future.delayed(Duration.zero, () async {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  snackBar('Invitación enviada', Colors.green),
                                );
                              }),
                              builder: (context, snapshot) {
                                return Container();
                              },
                            )
                        ],
                      ),
                    ),
                  ),
                );
              });
            });
          },
        );
      },
      label: Text(
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

Padding userEventWidget(BuildContext context, Event event, User user, Provider provider) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
    child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorStyles.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 0.5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 2,
                  child: Text(
                    event.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: ColorStyles.textSecondary1,
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      // Navigator.pop(context);
                      invitateWidget(context, event, user, provider);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: ColorStyles.primaryBlue,
                      minimumSize: const Size(double.infinity, 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Invitar',
                      style: TextStyle(
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Future<void> invitateWidget(BuildContext context, Event event, User user, Provider provider) {
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
                    '¿Deseas invitar como colaborador de tu evento a ${provider.companyName}? *',
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
                  '* Al invitar como colaborador a una empresa/proveedor aceptas compartir información de tu evento tal como el nombre del evento, descripción, fecha e imagenes anexas. Puedes deshacer la colaboración mas tarde.',
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
                    icon: const Icon(Icons.event),
                    label: const Text('Invitar'),
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
                      Notif.Notification notif = Notif.Notification(
                        senderId: user.userinfo['pk'],
                        receiverId: provider.userid,
                        title: 'Haz sido invitado a colaborar en un evento',
                        body: '${user.userinfo['full_name']} te ha invitado a colaborar al evento ${event.name}',
                        providerName: provider.companyName,
                        eventName: event.name,
                        type: 'Invitation',
                      );
                      context.read<NotificationBloc>().add(SendNotification(notification: notif, receiverToken: 'none'));
                      Navigator.pop(context);
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

Padding sendMessageToPorivderButton(BuildContext context, String label, User user, Provider provider) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: TextButton.icon(
      icon: const Icon(Icons.message, size: 22),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: ColorStyles.primaryBlue,
        minimumSize: const Size(double.infinity, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.black,
        elevation: 6,
      ),
      onPressed: () async {
        await SharedPreferences.getInstance().then((prefs) async {
          await prefs.setInt('providerUserId', provider.userid).then((value) async {
            await prefs.setString('providerName', provider.companyName).then((value) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(user, 2)),
                (Route<dynamic> route) => false,
              ); 
            });
          });
        });
      },
      label: Text(
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

Padding providerEditButton(BuildContext context, String label, Provider providerData, List<Service>? providerServices, int? providerUserId, User user) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    child: TextButton.icon(
      icon: Icon(providerServices == null ? Icons.edit : Icons.checklist),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: ColorStyles.primaryBlue,
        minimumSize: const Size(150, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.black,
        elevation: 6,
      ),
      onPressed: () {
        if (providerServices == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EditInformationScreen(providerData, user),
            ));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceListScreen(providerData, providerServices, providerUserId!, user),
            ));
        }
      },
      label: Text(
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

TextButton showMoreButton(BuildContext context, String label, Provider providerData, List<Service> providerServices, int? providerUserId, User user) {
  return TextButton(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: ColorStyles.textSecondary3,
      minimumSize: const Size(double.infinity, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black,
      elevation: 3,
    ),
    onPressed: () {
      if (label == 'Ver todos los servicios') {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ServiceListScreen(providerData, providerServices, providerUserId, user)));
      }
    },
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontFamily: 'Inter',
        fontSize: 16
      ),
    ),
  );
}