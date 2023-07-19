import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/event/presentation/widgets/text_field.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/category.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/event/presentation/widgets/button.dart';
import 'package:eventhub_app/features/event/presentation/widgets/alerts.dart';
import 'package:eventhub_app/home.dart';

class CreateEventScreen extends StatefulWidget {
  final User user;
  const CreateEventScreen(this.user, {super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final eventNameController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  String eventDate = 'Seleccionar fecha';
  List<String> selectedCategories = [];
  List<File> eventImages = [];

  DateTime selectedDate = DateTime.now();
  bool dateModified = false;
  String? dropdownValue;

  int currentIndexGalley = 0;

  List<String> categoriesList =
      allCategories.map((category) => category['name'].toString()).toList();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        helpText: 'Seleccionar fecha del evento',
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        eventDate = DateFormat('dd-MM-yyyy').format(selectedDate);
        dateModified = true;
      });
    }
  }

  Future _pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    File? img = File(image.path);
    img = await _cropImage(imageFile: img);
    setState(() {
      // _image = img;
      if (img != null) {
        eventImages.add(img);
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
    return BlocBuilder<EventBloc, EventState>(builder: (context, state) {
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
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Crear evento',
                        style: TextStyle(
                          color: ColorStyles.primaryGrayBlue,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const Divider(color: ColorStyles.baseLightBlue,),
                      Column(
                        children: [
                          textFieldMaxLength(context, 'Nombre del evento', eventNameController, 40),
                          textFieldLong(context, 'Descripción y necesidades generales', eventDescriptionController, 280),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextButton(
                              onPressed: () {
                                FocusManager.instance.primaryFocus?.unfocus();
                                _selectDate(context);
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: dateModified
                                    ? ColorStyles.black
                                    : ColorStyles.textSecondary3,
                                backgroundColor: Colors.white,
                                minimumSize: const Size(150, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                shadowColor: Colors.grey.withOpacity(0.5),
                                elevation: 2,
                              ),
                              child: Text(eventDate),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '¿Qué necesitas para tu evento?',
                              style: TextStyle(
                                color: ColorStyles.primaryGrayBlue,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                'Selecciona las categorías que se ajusten a tus necesidades para te podamos mostrar algunas opciones para que vuelvas realidad tu evento.',
                                style: TextStyle(
                                  color: ColorStyles.primaryGrayBlue,
                                  fontSize: 14,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
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
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                  dropdownValue = newValue;
                                                  selectedCategories.add(newValue!);
                                                }
                                              });
                                            },
                                            items: categoriesList.map<DropdownMenuItem<String>>((String value) {
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
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Imágenes ${eventImages.isEmpty ? '0' : currentIndexGalley+1}/${eventImages.length}',
                                  style: const TextStyle(
                                      color: ColorStyles.textPrimary2,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      _pickImage(ImageSource.gallery);
                                    },
                                    child: Container(
                                      height: 28,
                                      width: 28,
                                      decoration: const BoxDecoration(
                                        color: ColorStyles.primaryBlue,
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
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
                            if (eventImages.isNotEmpty)
                              CarouselSlider(
                                options: CarouselOptions(
                                  viewportFraction: 1,
                                  enableInfiniteScroll: false,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndexGalley = index;
                                    });
                                  }
                                ),
                                items: [
                                  for (int index = 0; index < eventImages.length; index++)
                                    Builder(
                                      builder: (BuildContext context) {
                                        return imagesCarousel(index);
                                      },
                                    ),
                                ],
                              ),
                            if (eventImages.isEmpty)
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  const Text(
                                    'Imágenes del evento',
                                    style: TextStyle(
                                      color: ColorStyles.primaryGrayBlue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                  Image.asset(Images.emptyImage),
                                ],
                              )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 2,
                              child: createAndViewEventBotton(
                                context, eventNameController,
                                eventDescriptionController, eventDate,
                                selectedCategories, eventImages,
                                widget.user, context.read<EventBloc>(),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Flexible(
                              flex: 2,
                              child: createEventBotton(
                                context, eventNameController,
                                eventDescriptionController, eventDate,
                                selectedCategories, eventImages,
                                widget.user, context.read<EventBloc>(),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (state is CreatingEvent)
            loadingEventWidget(context)
          else if (state is EventCreated)
            FutureBuilder(
              future: Future.delayed(Duration.zero, () async {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(widget.user, 0)),
                    (route) => false);
              }),
              builder: (context, snapshot) {
                return Container();
              },
            )
          else if (state is Error)
            errorEventAlert(context, state.error)
        ],
      );
    });
    // return Scaffold(
    //     backgroundColor: ColorStyles.baseLightBlue,
    //     body: BlocBuilder<EventBloc, EventState>(builder: (context, state) {
    //       return SafeArea(
    //         child: Stack(children: [
    //           Container(
    //             color: ColorStyles.baseLightBlue,
    //             child: NestedScrollView(
    //               floatHeaderSlivers: true,
    //               headerSliverBuilder: (context, innerBoxIsScrolled) => [
    //                 SliverAppBar(
    //                   automaticallyImplyLeading: false,
    //                   toolbarHeight: 70,
    //                   backgroundColor: ColorStyles.baseLightBlue,
    //                   title: GestureDetector(
    //                     onTap: () {
    //                       Navigator.pop(context);
    //                     },
    //                     child: Padding(
    //                       padding: const EdgeInsets.symmetric(horizontal: 10),
    //                       child: Row(
    //                         children: const [
    //                           Icon(
    //                             Icons.arrow_back_ios,
    //                             color: ColorStyles.white,
    //                             size: 16,
    //                           ),
    //                           Padding(
    //                             padding: EdgeInsets.symmetric(horizontal: 10),
    //                             child: Text(
    //                               'Regresar',
    //                               style: TextStyle(
    //                                 fontSize: 17,
    //                                 fontFamily: 'Inter',
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //               body: SingleChildScrollView(
    //                 child: Column(
    //                   children: [
    //                     Container(
    //                       width: double.infinity,
    //                       color: ColorStyles.primaryBlue,
    //                       child: Container(
    //                         width: double.infinity,
    //                         decoration: BoxDecoration(
    //                           color: ColorStyles.baseLightBlue,
    //                           border:
    //                               Border.all(color: ColorStyles.baseLightBlue),
    //                           borderRadius: const BorderRadius.only(
    //                             topLeft: Radius.circular(22),
    //                             topRight: Radius.circular(22),
    //                           ),
    //                         ),
    //                         child: const Padding(
    //                           padding: EdgeInsets.all(15),
    //                           child: Text(
    //                             'Crear evento',
    //                             style: TextStyle(
    //                               color: ColorStyles.primaryGrayBlue,
    //                               fontSize: 26,
    //                               fontWeight: FontWeight.w600,
    //                               fontFamily: 'Inter',
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
                        
                        
                        
                      
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
              
    //         ]),
    //       );
    //     }));
  }

  Stack imagesCarousel(int index) {
    return Stack(
      children: <Widget>[
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
              aspectRatio: 68 / 25,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(eventImages[index], fit: BoxFit.fitWidth),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              eventImages.removeAt(index);
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
  }
}
