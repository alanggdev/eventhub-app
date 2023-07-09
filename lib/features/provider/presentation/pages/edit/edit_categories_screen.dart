import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/keys.dart';
import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/provider/domain/entities/provider.dart';

import 'package:eventhub_app/features/provider/presentation/bloc/provider_bloc.dart';
import 'package:eventhub_app/features/provider/presentation/pages/provider_screen.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/category.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/button.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/alerts.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/text_field.dart';

class EditCategoriesScreen extends StatefulWidget {
  final Provider providerData;
  final List<String>? selectedCategories;
  final List<File>? companyImages;
  final List<String>? imagesPreLoaded;
  const EditCategoriesScreen(this.providerData, this.selectedCategories, this.companyImages, this.imagesPreLoaded, {super.key});

  @override
  State<EditCategoriesScreen> createState() => _EditCategoriesScreenState();
}

class _EditCategoriesScreenState extends State<EditCategoriesScreen> {
  String? dropdownValue;
  List<String> selectedCategories = [];
  List<File> companyImages = [];
  List<String> imagesPreLoaded = [];
  // List<Service> services = [];

  bool categoriesModified = false;

  List<String> categoriesList = allCategories.map((category) => category['name'].toString()).toList();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    if (widget.selectedCategories != null) {
      selectedCategories = widget.selectedCategories!;
    } else if (widget.selectedCategories == null) {
      selectedCategories = widget.providerData.categories.map((item) => item.toString()).toList();
    }

    if (widget.companyImages != null) {
      companyImages = widget.companyImages!;
    }

    if (widget.imagesPreLoaded != null) {
      imagesPreLoaded = widget.imagesPreLoaded!;
    } else if (widget.imagesPreLoaded == null) {
      imagesPreLoaded = widget.providerData.urlImages.map((item) => item.toString()).toList();
    }

    // if (widget.services != null) {
    //   services = widget.services!;
    // } else if (widget.services == null) {
    //   services = List.from(widget.providerServices);
    // }
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
    return BlocBuilder<ProviderBloc, ProviderState>(builder: (context, state) {
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
                                                if (!selectedCategories.contains(newValue)) {
                                                  categoriesModified = true;
                                                  dropdownValue = newValue;
                                                  selectedCategories.add(newValue!);
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
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 10),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       textInterW600('Servicios que brindas'),
                      //       const Divider(
                      //         color: ColorStyles.baseLightBlue,
                      //       ),
                      //       TextButton.icon(
                      //         icon: const Icon(Icons.add),
                      //         style: OutlinedButton.styleFrom(
                      //           foregroundColor: Colors.white,
                      //           backgroundColor: ColorStyles.textSecondary1,
                      //           minimumSize: const Size(double.infinity, 50),
                      //           shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(10),
                      //           ),
                      //           shadowColor: Colors.black,
                      //           elevation: 3,
                      //         ),
                      //         onPressed: () {
                      //           Navigator.pushReplacement(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) => AddServiceScreen(
                      //                       widget.providerData,
                      //                       widget.providerServices,
                      //                       selectedCategories,
                      //                       companyImages,
                      //                       imagesPreLoaded,
                      //                       services,
                      //                       null, null)));
                      //         },
                      //         label: const Text(
                      //           'Agregar servicio',
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 20,
                      //             fontWeight: FontWeight.w600,
                      //             fontFamily: 'Inter',
                      //           ),
                      //         ),
                      //       ),
                      //       if (services.isEmpty)
                      //         Center(
                      //           child: Padding(
                      //             padding:
                      //                 const EdgeInsets.symmetric(vertical: 15),
                      //             child: textInterW500(
                      //                 'Aún no tienes servicios agregados'),
                      //           ),
                      //         ),
                      //       if (services.isNotEmpty) Padding(
                      //         padding: const EdgeInsets.only(top: 15),
                      //         child: servicesWidgetCarousel(),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      if (imagesPreLoaded.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Imágenes cargadas',
                                  style: TextStyle(
                                    color: ColorStyles.textPrimary2,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              providerPreLoadedImagesCarousel(imagesPreLoaded),
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
                        child: saveProviderData(
                            context,
                            widget.providerData,
                            selectedCategories,
                            companyImages,
                            imagesPreLoaded,
                            context.read<ProviderBloc>()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (state is UpdatingProviderData)
            loadingProviderWidget(context)
          else if (state is ProviderDataUpdated)
            FutureBuilder(
              future: Future.delayed(Duration.zero, () async {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ProviderScreen(null, widget.providerData.userid)),
                  (Route<dynamic> route) => route.isFirst,
                );
              }),
              builder: (context, snapshot) {
                return Container();
              },
            )
          else if (state is Error)
            errorProviderAlert(context, state.error)
        ],
      );
    });
  }

  // CarouselSlider servicesWidgetCarousel() {
  //   return CarouselSlider(
  //     options:
  //         CarouselOptions(enableInfiniteScroll: false, viewportFraction: 1),
  //     items: [
  //       for (int index = 0; index < services.length; index++)
  //         Builder(
  //           builder: (BuildContext context) {
  //             return Stack(
  //               children: [
  //                 GestureDetector(
  //                   onTap: () {
  //                     Navigator.pushReplacement(
  //                       context,
  //                       MaterialPageRoute(
  //                           builder: (context) => AddServiceScreen(
  //                               widget.providerData, widget.providerServices,
  //                               selectedCategories, companyImages,
  //                               imagesPreLoaded, services,
  //                               services[index],
  //                               index),
  //                       ),
  //                     );
  //                   },
  //                   child: providerServiceWidget(context, services[index]),
  //                 ),
  //                 GestureDetector(
  //                   onTap: () {
  //                     showDialog<void>(
  //                       context: context,
  //                       builder: (BuildContext context) {
  //                         return AlertDialog(
  //                           shape: const RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.all(Radius.circular(10))
  //                           ),
  //                           backgroundColor: const Color(0xffF3E7E7),
  //                           content: Padding(
  //                             padding: const EdgeInsets.all(8),
  //                             child: SizedBox(
  //                               height: 80,
  //                               child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.center,
  //                                 crossAxisAlignment: CrossAxisAlignment.center,
  //                                 children: const [
  //                                   Padding(
  //                                     padding: EdgeInsets.only(bottom: 10),
  //                                     child: Text(
  //                                       '¿Deseas eliminar este servicio?',
  //                                       textAlign: TextAlign.center,
  //                                       style: TextStyle(
  //                                         color: ColorStyles.black,
  //                                         fontWeight: FontWeight.w600,
  //                                         fontFamily: 'Inter',
  //                                         fontSize: 20
  //                                       ),
  //                                     ),
  //                                   ),
  //                                   Text(
  //                                     'Una vez eliminado la información del servicio no podrá ser recuperada.',
  //                                     textAlign: TextAlign.center,
  //                                     style: TextStyle(
  //                                       color: ColorStyles.warningCancel,
  //                                       fontWeight: FontWeight.w500,
  //                                       fontFamily: 'Inter',
  //                                       fontSize: 16
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                           actions: <Widget>[
  //                             TextButton.icon(
  //                               icon: const Icon(Icons.close),
  //                               label: const Text('Cancelar'),
  //                               style: OutlinedButton.styleFrom(
  //                                 minimumSize: Size(MediaQuery.of(context).size.width * 0.3, 40),
  //                                 foregroundColor: Colors.white,
  //                                 backgroundColor: ColorStyles.textSecondary3,
  //                                 shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                 ),
  //                                 shadowColor: Colors.black,
  //                                 elevation: 3,
  //                               ),
  //                               onPressed: () {
  //                                 Navigator.of(context).pop();
  //                               },
  //                             ),
  //                             TextButton.icon(
  //                               icon: const Icon(Icons.delete),
  //                               label: const Text('Eliminar'),
  //                               style: OutlinedButton.styleFrom(
  //                                 minimumSize: Size(MediaQuery.of(context).size.width * 0.3, 40),
  //                                 foregroundColor: Colors.white,
  //                                 backgroundColor: ColorStyles.primaryGrayBlue,
  //                                 shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                 ),
  //                                 shadowColor: Colors.black,
  //                                 elevation: 3,
  //                               ),
  //                               onPressed: () {
  //                                 Navigator.of(context).pop();
  //                               },
  //                             ),
  //                           ],
  //                           actionsAlignment: MainAxisAlignment.center,
  //                           contentPadding: const EdgeInsets.only(bottom: 2),
  //                           actionsPadding: const EdgeInsets.only(bottom: 15),
  //                         );
  //                       },
  //                     );
  //                   },
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(top: 5),
  //                     child: Align(
  //                       alignment: Alignment.topRight,
  //                       child: Container(
  //                         alignment: Alignment.center,
  //                         height: 28,
  //                         width: 28,
  //                         decoration: const BoxDecoration(
  //                           color: ColorStyles.primaryBlue,
  //                           borderRadius: BorderRadius.all(Radius.circular(15)),
  //                         ),
  //                         child: const Icon(
  //                           Icons.delete,
  //                           color: ColorStyles.baseLightBlue,
  //                           size: 18,
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             );
  //           },
  //         ),
  //     ],
  //   );
  // }

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
                children:  [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 500,
                      decoration: BoxDecoration(
                        color: ColorStyles.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 5,
                              offset: const Offset(0, 1)),
                        ],
                      ),
                      child: AspectRatio(
                        aspectRatio: 64 / 25,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(companyImages[index], fit: BoxFit.fitWidth,),
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

  CarouselSlider providerPreLoadedImagesCarousel(List<String> imagesPreLoaded) {
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 1
      ),
      items: [
        for (int index = 0; index < imagesPreLoaded.length; index++)
          Builder(
            builder: (BuildContext context) {
              return Stack(
                children: [
                  Container(
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
                          child: FadeInImage(
                            fit: BoxFit.fitWidth,
                            alignment: FractionalOffset.center,
                            image: NetworkImage('$serverURL${imagesPreLoaded[index]}'),
                            placeholder: const AssetImage(Images.providerDetailPlaceholder),
                            imageErrorBuilder: (context, error, stackTrace) {
                              return const Center(child: Text('provider image'));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        imagesPreLoaded.removeAt(index);
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
