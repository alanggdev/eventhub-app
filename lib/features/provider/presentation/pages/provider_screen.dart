import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/keys.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/alerts.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/provider.dart';
import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/presentation/bloc/provider_bloc.dart';

class ProviderScreen extends StatefulWidget {
  final Provider provider;
  const ProviderScreen(this.provider, {super.key});

  @override
  State<ProviderScreen> createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {
  String? day;

  @override
  void initState() {
    super.initState();
    loadProviderData();
    getDay();
  }

  loadProviderData() {
    context.read<ProviderBloc>().add(GetProviderServices(providerid: widget.provider.providerId!));
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
          return SafeArea(
            child: Stack(
              children: [ 
                Container(
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
                                  size: 16,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'Regresar',
                                    style: TextStyle(
                                      fontSize: 17,
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
                                      image: NetworkImage(
                                          '$serverURL${widget.provider.urlImages[0]}'),
                                      placeholder: const AssetImage(
                                          Images.providerDetailPlaceholder),
                                      imageErrorBuilder: (context, error, stackTrace) {
                                        return const Center(
                                            child: Text('provider image'));
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
                                    widget.provider.companyName,
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
                                    widget.provider.companyDescription,
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
                                    children: widget.provider.categories.map((category) {
                                      return providerCategoryLabel(category);
                                    }).toList(),
                                    //
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Column(
                                    children: [
                                      providerInfo(Icons.phone, widget.provider.companyPhone),
                                      providerInfo(Icons.mail, widget.provider.companyEmail),
                                      providerDaysInfo(Icons.schedule, widget.provider.daysAvailability, day!, widget.provider.hoursAvailability),
                                      providerInfo(Icons.location_on, widget.provider.companyAddress),
                                    ],
                                  ),
                                ),
                                CarouselSlider(
                                  options: CarouselOptions(enableInfiniteScroll: false, viewportFraction: 1),
                                  items: [
                                    for (int index = 0;
                                        index < widget.provider.urlImages.length;
                                        index++)
                                      Builder(
                                        builder: (BuildContext context) {
                                          return providerImage(
                                              widget.provider.urlImages[index]);
                                        },
                                      ),
                                  ],
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    'Servicios',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: ColorStyles.primaryGrayBlue,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Inter',
                                    ),
                                  ),
                                ),
                                if (state is ProviderServicesLoaded)
                                  CarouselSlider(
                                    options: CarouselOptions(enableInfiniteScroll: false, viewportFraction: 1),
                                    items: [
                                      for (int index = 0;
                                          index < state.providerServices.length;
                                          index++)
                                        Builder(
                                          builder: (BuildContext context) {
                                            return serviceWidget(context, state.providerServices[index]);
                                          },
                                        ),
                                    ],
                                  ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    providerOptionButton(context, 'Invitar a evento'),
                                    providerOptionButton(context, 'Contactar'),
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
                if (state is LoadingProviderServices)
                  loadingCategoryWidget(context)
                else if (state is Error)
                  errorProviderAlert(context, state.error)
              ],
            ),
          );
        },
      ),
    );
  }
}
