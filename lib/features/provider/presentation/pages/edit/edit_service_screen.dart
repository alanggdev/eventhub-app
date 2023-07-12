import 'package:flutter/material.dart';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/keys.dart';

import 'package:eventhub_app/features/provider/presentation/bloc/provider_bloc.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/text_field.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/alerts.dart';
import 'package:eventhub_app/features/provider/presentation/pages/provider_screen.dart';
import 'package:eventhub_app/features/provider/domain/entities/service.dart';

import 'package:eventhub_app/features/auth/domain/entities/user.dart';

class EditServiceScreen extends StatefulWidget {
  final Service? serviceToUpdate;
  final int providerId;
  final int userid;
  final User user;
  const EditServiceScreen(this.serviceToUpdate, this.providerId, this.userid, this.user, {super.key});

  @override
  State<EditServiceScreen> createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  Service? serviceToUpdate;
  int? providerId;

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  List<dynamic> tags = [];
  List<File> images = [];
  List<String>? imagesPreLoaded = [];

  final tagsController = TextEditingController();
  int currentIndexImagesPreLoaded = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    providerId = widget.providerId;

    if (widget.serviceToUpdate != null) {
      serviceToUpdate = widget.serviceToUpdate;

      nameController.text = serviceToUpdate!.name;
      descriptionController.text = serviceToUpdate!.description;
      tags = serviceToUpdate!.tags;
      imagesPreLoaded = serviceToUpdate!.imagePaths!.map((item) => item.toString()).toList();
    }
  }

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
              title: TextButton.icon(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorStyles.primaryGrayBlue,
                  size: 15,
                ),
                label: const Text(
                  'Regresar',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Inter',
                    color: ColorStyles.primaryGrayBlue,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                if (serviceToUpdate != null) 
                  PopupMenuButton(
                    icon: const Icon(Icons.more_vert, color: ColorStyles.primaryGrayBlue, size: 28),
                    padding: const EdgeInsets.only(bottom: 10),
                    onSelected: (value) {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            backgroundColor: const Color(0xffF3E7E7),
                            content: Padding(
                              padding: const EdgeInsets.all(8),
                              child: SizedBox(
                                height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                          fontSize: 20
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Una vez eliminado la información del servicio no podrá ser recuperada.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: ColorStyles.warningCancel,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Inter',
                                        fontSize: 16
                                      ),
                                    ),
                                  ],
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
                                  context.read<ProviderBloc>().add(DeleteProviderService(servideid: serviceToUpdate!.serviceId!));
                                },
                              ),
                            ],
                            actionsAlignment: MainAxisAlignment.center,
                            contentPadding: const EdgeInsets.only(bottom: 2),
                            actionsPadding: const EdgeInsets.only(bottom: 15),
                          );
                        },
                      );
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
                    ],
                  ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: textInterW600('Información del servicio'),
                    ),
                    const Divider(color: ColorStyles.baseLightBlue),
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
                    if (imagesPreLoaded!.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                            servicePreLoadedImagesCarousel(),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                '${currentIndexImagesPreLoaded+1}/${imagesPreLoaded!.length}',
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  color: ColorStyles.textPrimary2
                                ),
                              )
                            ),
                          ],
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
                            ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      child: TextButton(
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

                          if (name.isNotEmpty && description.isNotEmpty && tags.isNotEmpty && tags.length > 1 && images.isNotEmpty || imagesPreLoaded!.isNotEmpty) {
                            if (serviceToUpdate != null) {
                              serviceToUpdate!.name = name;
                              serviceToUpdate!.description = description;
                              serviceToUpdate!.tags = tags;
                              serviceToUpdate!.imagePaths = imagesPreLoaded;
                              serviceToUpdate!.images = images;
                              
                              // send to update
                              context.read<ProviderBloc>().add(UpdateProviderService(service: serviceToUpdate!));
                            } else {
                              Service newService = Service(name: name, description: description, tags: tags, images: images);

                              // send to create
                              context.read<ProviderBloc>().add(CreateProviderServices(service: newService, providerid: providerId!));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBar('No se permiten cambios vacios'),
                            );
                          }
                        },
                        child: const Text(
                          'Guardar',
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
          ),
          if (state is UpdatingProviderServices)
            loadingProviderWidget(context)
          else if (state is ProviderServicesUpdated)
            FutureBuilder(
              future: Future.delayed(Duration.zero, () async {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ProviderScreen(null, widget.userid, widget.user)),
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

  CarouselSlider servicePreLoadedImagesCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: false,
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          setState(() {
            currentIndexImagesPreLoaded = index;
          });
        }
      ),
      items: [
        for (int index = 0; index < imagesPreLoaded!.length; index++)
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
                            image: NetworkImage('$serverURL${imagesPreLoaded![index]}'),
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
                        imagesPreLoaded!.removeAt(index);
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
              return Stack(
                children: <Widget>[
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
                          child: Image.file(images[index], fit: BoxFit.fitWidth),
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
