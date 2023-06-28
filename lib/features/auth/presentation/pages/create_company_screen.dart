import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/text_field.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/text.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/button.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/category.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_provider.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/alerts.dart';
import 'package:eventhub_app/features/auth/presentation/pages/sign_in_screen.dart';

class CreateCompanyScreen extends StatefulWidget {
  final RegisterUser registerUserData;
  const CreateCompanyScreen(this.registerUserData, {super.key});

  @override
  State<CreateCompanyScreen> createState() => _CreateCompanyScreenState();
}

class _CreateCompanyScreenState extends State<CreateCompanyScreen> {
  final companyNameController = TextEditingController();
  final companyDescriptionController = TextEditingController();
  final companyPhoneController = TextEditingController();
  final companyEmailController = TextEditingController();
  final companyAddressController = TextEditingController();
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textInterW600('Información'),
                      textFieldFormCompany(context, 'Nombre de la empresa',
                          companyNameController),
                      textFieldFormCompany(context, 'Descripción general',
                          companyDescriptionController),
                      textFieldFormCompany(context, 'Teléfono de la empresa',
                          companyPhoneController),
                      textFieldFormCompany(context, 'Email de la empresa',
                          companyEmailController),
                      textFieldFormCompany(context, 'Dirección de la empresa',
                          companyAddressController),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
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
                  padding: const EdgeInsets.symmetric(vertical: 15),
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
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 3)),
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
                      label == 'De:'
                          ? openTime = time!.format(context)
                          : closeTime = time!.format(context);
                      // ? selectedFirstTime = time
                      // : selectedLastime = time;
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

class AddInfoCompanyScreen extends StatefulWidget {
  final RegisterUser registerUserData;
  final RegisterProvider registerProviderData;
  const AddInfoCompanyScreen(this.registerUserData, this.registerProviderData,
      {super.key});

  @override
  State<AddInfoCompanyScreen> createState() => _AddInfoCompanyScreenState();
}

class _AddInfoCompanyScreenState extends State<AddInfoCompanyScreen> {
  String? dropdownValue;
  List<String> selectedCategories = [];
  List<File> companyImages = [];

  List<String> categoriesList =
      allCategories.map((category) => category['name'].toString()).toList();

  Future _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    File? img = File(image.path);
    img = await _cropImage(imageFile: img);
    setState(() {
      if (img != null) {
        companyImages.add(img);
      }
    });
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [CropAspectRatioPreset.ratio4x3],
      uiSettings: [
        AndroidUiSettings(
          toolbarWidgetColor: ColorStyles.baseLightBlue,
          toolbarColor: ColorStyles.primaryBlue,
          statusBarColor: ColorStyles.primaryBlue,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true,
          hideBottomControls: true,
        ),
      ],
    );
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Stack(
        children: [
          Scaffold(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textInterW600('Categorías que brindas'),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Text(
                                          'Categorías:',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'Inter',
                                            color: ColorStyles.secondaryColor3,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<String>(
                                            value: dropdownValue,
                                            underline: const SizedBox(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                if (!selectedCategories
                                                    .contains(newValue)) {
                                                  dropdownValue = newValue;
                                                  selectedCategories
                                                      .add(newValue!);
                                                }
                                              });
                                            },
                                            items: categoriesList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Wrap(
                              spacing: 8.0,
                              children: selectedCategories.map((option) {
                                return Chip(
                                  backgroundColor: ColorStyles.primaryBlue,
                                  labelStyle: const TextStyle(
                                    color: ColorStyles.baseLightBlue,
                                    fontFamily: 'Inter',
                                  ),
                                  label: Text(option),
                                  deleteIcon: const Icon(
                                    Icons.delete,
                                    color: ColorStyles.baseLightBlue,
                                    size: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  onDeleted: () {
                                    setState(() {
                                      selectedCategories.remove(option);
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Imágenes de portada',
                                  style: TextStyle(
                                      color: ColorStyles.textPrimary2,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      _pickImage(ImageSource.gallery);
                                    },
                                    child: Container(
                                      height: 28,
                                      width: 28,
                                      decoration: const BoxDecoration(
                                        color: ColorStyles.primaryBlue,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),
                                      child: const Icon(
                                        Icons.add,
                                        color: ColorStyles.baseLightBlue,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: ColorStyles.baseLightBlue,
                            ),
                            if (companyImages.isNotEmpty)
                              CarouselSlider(
                                options: CarouselOptions(
                                  aspectRatio: 4 / 3,
                                  enableInfiniteScroll: false,
                                ),
                                items: [
                                  for (int index = 0;
                                      index < companyImages.length;
                                      index++)
                                    Builder(
                                      builder: (BuildContext context) {
                                        // return Image.file(i);
                                        return Stack(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: ColorStyles.white,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        spreadRadius: 1,
                                                        blurRadius: 4,
                                                        offset:
                                                            const Offset(0, 3)),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    child: Image.file(
                                                        companyImages[index]),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  companyImages.removeAt(index);
                                                });
                                              },
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 28,
                                                  width: 28,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color:
                                                        ColorStyles.primaryBlue,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15)),
                                                  ),
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: ColorStyles
                                                        .baseLightBlue,
                                                    size: 18,
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                ],
                              ),
                            if (companyImages.isEmpty)
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  textInterW500('Agregar imagenes'),
                                  Image.asset(Images.emptyImage),
                                ],
                              )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: formButtonCreateCompany(
                            context,
                            widget.registerUserData,
                            widget.registerProviderData,
                            selectedCategories,
                            companyImages,
                            context.read<AuthBloc>()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (state is CreatingProvider)
            loadingWidget(context)
          else if (state is ProviderCreated)
            FutureBuilder(
              future: Future.delayed(Duration.zero, () async {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInScreen()));
              }),
              builder: (context, snapshot) {
                return Container();
              },
            )
          else if (state is Error)
            errorAlert(context, state.error)
        ],
      );
    });
  }
}
