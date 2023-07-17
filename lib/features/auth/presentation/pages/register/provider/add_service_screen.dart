import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/auth/presentation/pages/register/provider/add_info_company_screen.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/text.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/text_field.dart';
import 'package:eventhub_app/features/auth/presentation/widgets/alerts.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_user.dart';
import 'package:eventhub_app/features/auth/domain/entities/register_provider.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';

import 'package:eventhub_app/features/provider/domain/entities/service.dart';

class AddService extends StatefulWidget {
  final RegisterUser registerUserData;
  final RegisterProvider registerProviderData;
  final List<String> selectedCategories;
  final List<File> companyImages;
  final List<Service> services;
  final User? userData;
  const AddService(this.registerUserData, this.registerProviderData,
      this.selectedCategories, this.companyImages, this.services, this.userData,
      {super.key});

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final tagsController = TextEditingController();

  List<dynamic> tags = [];
  List<File> images = [];

  Future _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    File? img = File(image.path);
    img = await _cropImage(imageFile: img);
    setState(() {
      if (img != null) {
        images.add(img);
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AddInfoCompanyScreen(
                  widget.registerUserData,
                  widget.registerProviderData,
                  widget.selectedCategories,
                  widget.companyImages,
                  widget.services,
                  widget.userData),
            ));
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
                  // Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddInfoCompanyScreen(
                            widget.registerUserData,
                            widget.registerProviderData,
                            widget.selectedCategories,
                            widget.companyImages,
                            widget.services,
                            widget.userData),
                      ));
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: textInterW600('Información del servicio'),
                  ),
                  textFieldMaxLength(context, Icons.info, 'Nombre del servicio', nameController, 35),
                  textFieldLong(context,Icons.description, 'Descripción general', descriptionController, 280),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: textFieldMaxLength(context, Icons.sell, 'Etiquetas', tagsController, 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40, bottom: 12),
                        child: GestureDetector(
                          onTap: () {
                            String tagToAdd = tagsController.text.trim();
                            if (tagToAdd.isNotEmpty && tags.length < 6) {
                              setState(() {
                                tags.add(tagToAdd);
                              });
                              tagsController.clear();
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              color: ColorStyles.secondaryColor1,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Agrega etiquetas (palabras clave) que identifiquen o que sean relevantes para tu servicio. Min. 2 y Max. 6',
                      style: TextStyle(
                        color: ColorStyles.textPrimary2,
                        fontFamily: 'Inter',
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(
                        spacing: 6,
                        children: tags.map((option) {
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
                                tags.remove(option);
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                        if (images.isNotEmpty)
                          servicesImagesCarousel(),
                        if (images.isEmpty)
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextButton.icon(
                  icon: const Icon(Icons.add),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: ColorStyles.primaryBlue,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: Colors.black,
                    elevation: 6,
                  ),
                  onPressed: () {
                    String name = nameController.text.trim();
                    String description = descriptionController.text.trim();
                    if (name.isNotEmpty && description.isNotEmpty && tags.isNotEmpty && tags.length > 1 && images.isNotEmpty) {
                      Service serviceToAdd = Service(name: name, description: description, tags: tags, images: images);
                      List<Service> services = widget.services;
                      services.add(serviceToAdd);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddInfoCompanyScreen(
                                widget.registerUserData,
                                widget.registerProviderData,
                                widget.selectedCategories,
                                widget.companyImages,
                                services, widget.userData,
                              ),
                            )
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        snackBar('No se permiten cambios vacios'),
                      );
                    }
                    
                  },
                  label: const Text(
                    'Agregar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CarouselSlider servicesImagesCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 1
      ),
      items: [
        for (int index = 0; index < images.length; index++)
          Builder(
            builder: (BuildContext context) {
              // return Image.file(i);
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
                            child: Image.file(images[index], fit: BoxFit.fitWidth),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        images.removeAt(index);
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
                  )
                ],
              );
            },
          ),
      ],
    );
  }
}
