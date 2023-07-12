import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/provider/domain/entities/service.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/provider.dart';

class ServiceScreen extends StatefulWidget {
  final Service service;
  const ServiceScreen(this.service, {super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  Service? service;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    service = widget.service;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.primaryBlue,
      body: SafeArea(
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
                  Container(
                    width: double.infinity,
                    color: ColorStyles.primaryBlue,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorStyles.baseLightBlue,
                        border: Border.all(color: ColorStyles.baseLightBlue),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(22),
                          topRight: Radius.circular(22),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          service!.name,
                          style: const TextStyle(
                            color: ColorStyles.primaryGrayBlue,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            enableInfiniteScroll: false, viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentIndex = index;
                              });
                            }
                          ),
                          items: [
                            for (int index = 0; index < service!.imagePaths!.length; index++)
                              Builder(
                                builder: (BuildContext context) {
                                  return providerImage(service!.imagePaths![index]);
                                },
                              ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            '${currentIndex+1}/${service!.imagePaths!.length}',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: ColorStyles.textPrimary2
                            ),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            service!.description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              color: ColorStyles.primaryGrayBlue
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            spacing: 8,
                            children: service!.tags.map((category) {
                              return providerCategoryLabel(category);
                            }).toList(),
                            //
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
