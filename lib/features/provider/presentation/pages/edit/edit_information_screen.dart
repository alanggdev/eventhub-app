import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/provider/presentation/widgets/text_field.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/button.dart';
import 'package:eventhub_app/features/provider/presentation/pages/provider_screen.dart';
import 'package:eventhub_app/features/provider/domain/entities/provider.dart';


class EditInformationScreen extends StatefulWidget {
  final Provider providerData;
  const EditInformationScreen(this.providerData,{super.key});

  @override
  State<EditInformationScreen> createState() => _EditInformationScreenState();
}

class _EditInformationScreenState extends State<EditInformationScreen> {
  final companyNameController = TextEditingController();
  final companyDescriptionController = TextEditingController();
  final companyPhoneController = TextEditingController();
  final companyEmailController = TextEditingController();
  final companyAddressController = TextEditingController();
  List<String> _selectedDays = [];
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
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    companyNameController.text = widget.providerData.companyName;
    companyDescriptionController.text = widget.providerData.companyDescription;
    companyPhoneController.text = widget.providerData.companyPhone;
    companyEmailController.text = widget.providerData.companyEmail;
    companyAddressController.text = widget.providerData.companyAddress;
    _selectedDays = widget.providerData.daysAvailability.map((item) => item.toString()).toList();
    openTime = widget.providerData.hoursAvailability[0];
    closeTime = widget.providerData.hoursAvailability[1];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ProviderScreen(null, widget.providerData.userid),),
            (Route<dynamic> route) => route.isFirst,
          );
        return false;
      },
      child: Scaffold(
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
                    textField(context, Icons.location_on, 'Dirección de la empresa', companyAddressController, TextInputType.text),
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
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: const Offset(0, 1)),
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
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: providerNextPage(
                      context,
                      widget.providerData,
                      companyNameController,
                      companyDescriptionController,
                      companyPhoneController,
                      companyEmailController,
                      companyAddressController,
                      _selectedDays,
                      openTime,
                      closeTime),
                ),
              ],
            ),
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
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 1)),
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
