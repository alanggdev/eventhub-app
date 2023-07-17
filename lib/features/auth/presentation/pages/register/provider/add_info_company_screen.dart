import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/auth/presentation/pages/register/provider/add_service_screen.dart';
import 'package:eventhub_app/features/auth/presentation/pages/login/sign_in_screen.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/text.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/button.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/company.dart';
import 'package:eventhub_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_provider.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/alerts.dart';

import 'package:eventhub_app/features/provider/presentation/widgets/category.dart';
import 'package:eventhub_app/features/provider/domain/entities/service.dart';

class AddInfoCompanyScreen extends StatefulWidget {
  final RegisterUser registerUserData;
  final RegisterProvider registerProviderData;
  final List<String>? selectedCategories;
  final List<File>? companyImages;
  final List<Service>? services;
  const AddInfoCompanyScreen(this.registerUserData, this.registerProviderData,
      this.selectedCategories, this.companyImages, this.services,
      {super.key});

  @override
  State<AddInfoCompanyScreen> createState() => _AddInfoCompanyScreenState();
}

class _AddInfoCompanyScreenState extends State<AddInfoCompanyScreen> {
  String? dropdownValue;
  List<String> selectedCategories = [];
  List<File> companyImages = [];
  List<Service> services = [];

  List<String> categoriesList =
      allCategories.map((category) => category['name'].toString()).toList();

  @override
  void initState() {
    super.initState();
    if (widget.selectedCategories != null) {
      selectedCategories = widget.selectedCategories!;
    }
    if (widget.companyImages != null) {
      companyImages = widget.companyImages!;
    }
    if (widget.services != null) {
      services = widget.services!;
    }
  }

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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                        color: Colors.grey.withOpacity(0.25),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: const Offset(0, 1)),
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
                            const Text(
                              'Agrega categorias que identifiquen o que sean relevantes para tu empresa. Min. 2',
                              style: TextStyle(
                                color: ColorStyles.textPrimary2,
                                fontFamily: 'Inter',
                                fontSize: 12,
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Wrap(
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
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textInterW600('Servicios que brindas'),
                            const Divider(
                              color: ColorStyles.baseLightBlue,
                            ),
                            TextButton.icon(
                              icon: const Icon(Icons.add),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: ColorStyles.textSecondary1,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadowColor: Colors.black,
                                elevation: 3,
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddService(
                                            widget.registerUserData,
                                            widget.registerProviderData,
                                            selectedCategories,
                                            companyImages,
                                            services)));
                              },
                              label: const Text(
                                'Agregar servicio',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                            if (services.isEmpty)
                              Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15),
                                  child: textInterW500(
                                      'Aún no tienes servicios agregados'),
                                ),
                              ),
                            if (services.isNotEmpty) servicesWidgetCarousel(),
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
                              providerImagesCarousel(),
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
                            services,
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

  CarouselSlider servicesWidgetCarousel() {
    return CarouselSlider(
      options:
          CarouselOptions(enableInfiniteScroll: false, viewportFraction: 1),
      items: [
        for (int index = 0; index < services.length; index++)
          Builder(
            builder: (BuildContext context) {
              return Stack(
                children: [
                  serviceWidget(context, services[index]),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        services.removeAt(index);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          alignment: Alignment.center,
                          height: 28,
                          width: 28,
                          decoration: const BoxDecoration(
                            color: ColorStyles.primaryBlue,
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: const Icon(
                            Icons.delete,
                            color: ColorStyles.baseLightBlue,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
      ],
    );
  }

  CarouselSlider providerImagesCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 1
      ),
      items: [
        for (int index = 0; index < companyImages.length; index++)
          Builder(
            builder: (BuildContext context) {
              return Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      height: 500,
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
                            child: Image.file(companyImages[index], fit: BoxFit.fitWidth),
                          ),
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
                        decoration: const BoxDecoration(
                          color: ColorStyles.primaryBlue,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: const Icon(
                          Icons.delete,
                          color: ColorStyles.baseLightBlue,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
      ],
    );
  }
}
