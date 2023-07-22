import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/keys.dart';

import 'package:eventhub_app/features/provider/presentation/widgets/alerts.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/provider.dart';
import 'package:eventhub_app/features/provider/presentation/bloc/provider_bloc.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/button.dart';
import 'package:eventhub_app/features/provider/presentation/pages/service_screen.dart';
import 'package:eventhub_app/features/provider/presentation/pages/location_screen.dart';

import 'package:eventhub_app/features/auth/domain/entities/user.dart';

class ProviderScreen extends StatefulWidget {
  final int? providerId; // From categories
  final int? providerUserId; // From my provider 
  final User user; // User visit
  const ProviderScreen(this.providerId, this.providerUserId, this.user, {super.key});

  @override
  State<ProviderScreen> createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {
  String? day;
  int currentIndexGalley = 0;
  int currentIndexServices = 0;

  @override
  void initState() {
    super.initState();
    loadProviderData();
    getDay();
  }

  loadProviderData() {
    if (widget.providerId != null) {
      context.read<ProviderBloc>().add(GetProviderDetailById(providerid: widget.providerId!));
    } else if (widget.providerUserId != null) {
      context.read<ProviderBloc>().add(GetProviderDetailByUserId(providerUserId: widget.providerUserId!));
    }
  }

  getDay() {
    initializeDateFormatting('es');
    DateTime now = DateTime.now();
    day = DateFormat('EEEE', 'es').format(now);

    String firstLetter = day![0].toUpperCase();
    String restOfWord = day!.substring(1);

    day = removeDiacritics('$firstLetter$restOfWord');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.primaryBlue,
      body: BlocBuilder<ProviderBloc, ProviderState>(
        builder: (context, state) {
          if (state is LoadingProviderDetail) {
            return Container(
              color: ColorStyles.baseLightBlue,
              child: loadingProviderWidget(context),
            );
          } else if (state is ProviderDetailLoaded) {
            return SafeArea(
              child: Container(
                color: ColorStyles.baseLightBlue,
                child: NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      toolbarHeight: 55,
                      backgroundColor: ColorStyles.primaryBlue,
                      title: TextButton.icon(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: ColorStyles.white,
                          size: 15,
                        ),
                        label: const Text(
                          'Regresar',
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Inter',
                            color: ColorStyles.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              color: ColorStyles.primaryBlue,
                              child: AspectRatio(
                                aspectRatio: 2 / 1,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  child: FadeInImage(
                                    fit: BoxFit.fitWidth,
                                    alignment: FractionalOffset.center,
                                    image: NetworkImage('$serverURL${state.providerData.urlImages[0]}'),
                                    placeholder: const AssetImage(Images.providerDetailPlaceholder),
                                    imageErrorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Text('provider image'),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 15,
                              decoration: BoxDecoration(
                                color: ColorStyles.baseLightBlue,
                                border: Border.all(color: ColorStyles.baseLightBlue),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  state.providerData.companyName,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: ColorStyles.primaryGrayBlue,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                  state.providerData.companyDescription,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: ColorStyles.primaryGrayBlue,
                                    fontSize: 16,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Wrap(
                                  spacing: 8,
                                  children: state.providerData.categories.map((category) {
                                    return providerCategoryLabel(category);
                                  }).toList(),
                                  //
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  children: [
                                    providerInfo(Icons.phone, state.providerData.companyPhone),
                                    providerInfo(Icons.mail, state.providerData.companyEmail),
                                    providerDaysInfo(Icons.schedule, state.providerData.daysAvailability, day!, state.providerData.hoursAvailability),
                                    providerInfo(Icons.location_on, state.providerData.companyAddress),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: SizedBox.fromSize(
                                  size: const Size(double.infinity, 200),
                                  child: LocationScreen(initialLocation: LatLng(state.providerData.location![0], state.providerData.location![1])),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Galeria ${currentIndexGalley+1}/${state.providerData.urlImages.length}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: ColorStyles.primaryGrayBlue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                              CarouselSlider(
                                options: CarouselOptions(
                                  enableInfiniteScroll: false, viewportFraction: 1,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndexGalley = index;
                                    });
                                  }
                                ),
                                items: [
                                  for (int index = 0; index < state.providerData.urlImages.length; index++)
                                    Builder(
                                      builder: (BuildContext context) {
                                        return providerImage(state.providerData.urlImages[index]);
                                      },
                                    ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'Servicios ${currentIndexServices+1}/${state.providerServices.length}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: ColorStyles.primaryGrayBlue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                              CarouselSlider(
                                options: CarouselOptions(
                                  enableInfiniteScroll: false, viewportFraction: 1,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentIndexServices = index;
                                    });
                                  }
                                ),
                                items: [
                                  for (int index = 0; index < state.providerServices.length; index++)
                                    Builder(
                                      builder: (BuildContext context) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceScreen(state.providerServices[index])));
                                          },
                                          child: providerServiceWidget(context, state.providerServices[index])
                                        );
                                      },
                                    ),
                                ],
                              ),
                              showMoreButton(context, 'Ver todos los servicios', state.providerData, state.providerServices, widget.providerUserId, widget.user),
                              if (widget.providerUserId == null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      flex: 2,
                                      child: providerInviteButton(context, 'Invitar a evento', widget.user, state.providerData),
                                    ),
                                    Flexible(
                                      flex: 2,
                                      child: sendMessageToPorivderButton(context, 'Contactar', widget.user, state.providerData),
                                    ),
                                  ],
                                )
                              else if (widget.providerUserId != null && widget.providerUserId == state.providerData.userid)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    providerEditButton(context, 'Editar información', state.providerData, null, null, widget.user),
                                    providerEditButton(context, 'Editar Servicios', state.providerData, state.providerServices, widget.providerUserId!, widget.user),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (state is Error) {
            return Container(
              color: ColorStyles.baseLightBlue,
              child: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    toolbarHeight: 55,
                    backgroundColor: ColorStyles.primaryBlue,
                    title: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.arrow_back_ios,
                              color: ColorStyles.white,
                              size: 15,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                'Regresar',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                body: errorProviderWidget(context, state.error),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
