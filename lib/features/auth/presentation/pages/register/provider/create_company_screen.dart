import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/auth/presentation/pages/register/provider/map_picker_dialog.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/text_field.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/text.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/button.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';

class CreateCompanyScreen extends StatefulWidget {
  final RegisterUser registerUserData;
  final User? userData;
  const CreateCompanyScreen(this.registerUserData, this.userData, {super.key});

  @override
  State<CreateCompanyScreen> createState() => _CreateCompanyScreenState();
}

class _CreateCompanyScreenState extends State<CreateCompanyScreen> {
  final companyNameController = TextEditingController();
  final companyDescriptionController = TextEditingController();
  final companyPhoneController = TextEditingController();
  final companyEmailController = TextEditingController();
  final companyAddressController = TextEditingController();
  List<String> companyLocation = [];
  final List<String> _selectedDays = [];
  TimeOfDay? selectedFirstTime, selectedLastime;
  String openTime = 'Seleccionar';
  String closeTime = 'Seleccionar';

  TimePickerEntryMode entryMode = TimePickerEntryMode.dialOnly;
  TextDirection textDirection = TextDirection.ltr;
  MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;
  bool use24HourTime = false;
  List<String> days = [
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado',
    'Domingo'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.baseLightBlue,
      appBar: AppBar(
        backgroundColor: ColorStyles.baseLightBlue,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 60,
        title: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.arrow_back_ios,
                    color: ColorStyles.primaryGrayBlue,
                    size: 15,
                  ),
                  Text(
                    'Regresar',
                    style: TextStyle(
                      fontSize: 15,
                      // fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: ColorStyles.primaryGrayBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: textInterW600('Información de la empresa'),
                  ),
                  textFieldMaxLength(context, Icons.business, 'Nombre de la empresa', companyNameController, 35),
                  textFieldLong(context,Icons.description, 'Descripción general', companyDescriptionController, 280),
                  textField(context, Icons.phone, 'Teléfono', companyPhoneController, TextInputType.phone),
                  textField(context, Icons.mail, 'Correo electrónico', companyEmailController, TextInputType.emailAddress),
                  textField(context, Icons.location_pin, 'Dirección de la empresa', companyAddressController, TextInputType.text),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: TextButton.icon(
                      icon: const FaIcon(FontAwesomeIcons.mapLocationDot),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: ColorStyles.white,
                        backgroundColor: ColorStyles.secondaryColor3,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadowColor: Colors.grey.withOpacity(0.125),
                        elevation: 3,
                      ),
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        Location location = Location();
                  
                        bool serviceEnabled;
                        PermissionStatus permissionGranted;
                        LocationData locationData;
                  
                        serviceEnabled = await location.serviceEnabled();
                        if (!serviceEnabled) {
                          serviceEnabled = await location.requestService();
                          if (!serviceEnabled) {
                            return;
                          }
                        }
                  
                        permissionGranted = await location.hasPermission();
                        if (permissionGranted == PermissionStatus.denied) {
                          permissionGranted = await location.requestPermission();
                          if (permissionGranted != PermissionStatus.granted) {
                            return;
                          }
                        }
                  
                        locationData = await location.getLocation();
                        Future.microtask(() {
                          showDialog(
                            context: context,
                            builder: (context) {
                            return MapPickerDialog(initialLocation: LatLng(locationData.latitude!, locationData.longitude!));
                          }).then((newLocation) {
                            if (newLocation != null) {
                              LatLng coords = newLocation;
                              setState(() {
                                companyLocation.clear();
                                companyLocation.add(coords.latitude.toString());
                                companyLocation.add(coords.longitude.toString());
                              });
                            }
                          });
                        });
                      },
                      label: Text(
                        companyLocation.isEmpty ? 'Seleccionar ubicación' : 'Ubicación seleccionada',
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textInterW600('Disponibilidad'),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          textInterW500('Días de servicio'),
                          const Divider(
                            color: ColorStyles.baseLightBlue,
                          ),
                          Wrap(
                            spacing: 8,
                            children: List.generate(days.length, (index) {
                              final dayName = days[index];
                              final isSelected =
                                  _selectedDays.contains(dayName);
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      _selectedDays.remove(dayName);
                                    } else {
                                      _selectedDays.add(dayName);
                                    }
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? ColorStyles.primaryBlue
                                        : ColorStyles.secondaryColor3,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.125),
                                        blurRadius: 4,
                                        offset: const Offset(0, 0.35)),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      dayName.substring(0, 3),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          textInterW500('Horas de servicio'),
                          const Divider(
                            color: ColorStyles.baseLightBlue,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              selectHour(context, 'De:', selectedFirstTime),
                              selectHour(context, 'A:', selectedLastime),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: formButtonNextCompany(
                    context,
                    widget.registerUserData,
                    companyNameController,
                    companyDescriptionController,
                    companyPhoneController,
                    companyEmailController,
                    companyAddressController,
                    _selectedDays,
                    openTime,
                    closeTime,
                    companyLocation,
                    widget.userData),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container selectHour(
      BuildContext context, String label, TimeOfDay? selectedTime) {
    return Container(
      decoration: BoxDecoration(
        color: ColorStyles.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.125),
              blurRadius: 4,
              offset: const Offset(0, 0.35)),
      ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
            child: Row(
              children: [
                textInterW500(label),
                TextButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: selectedTime ?? TimeOfDay.now(),
                      initialEntryMode: entryMode,
                      helpText: 'Seleccionar hora',
                      builder: (BuildContext context, Widget? child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            materialTapTargetSize: tapTargetSize,
                          ),
                          child: Directionality(
                            textDirection: textDirection,
                            child: MediaQuery(
                              data: MediaQuery.of(context).copyWith(
                                alwaysUse24HourFormat: use24HourTime,
                              ),
                              child: child!,
                            ),
                          ),
                        );
                      },
                    );
                    setState(() {
                      if (time != null) {
                        label == 'De:'
                            ? openTime = time.format(context)
                            : closeTime = time.format(context);
                      }
                    });
                  },
                  child: Text(
                    label == 'De:' ? openTime : closeTime,
                    // ? selectedFirstTime == null
                    //     ? 'Seleccionar'
                    //     : selectedFirstTime!.format(context)
                    // : selectedLastime == null
                    //     ? 'Seleccionar'
                    //     : selectedLastime!.format(context),
                    style: const TextStyle(
                      // fontSize: 18,
                      fontFamily: 'Inter',
                      color: ColorStyles.primaryBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
