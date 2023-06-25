import 'package:eventhub_app/features/event/presentation/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/event/presentation/widgets/event.dart';

import 'package:eventhub_app/features/provider/presentation/widgets/provider.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.baseLightBlue,
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 65,
              backgroundColor: ColorStyles.baseLightBlue,
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
                        color: ColorStyles.primaryGrayBlue,
                        size: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Boda test',
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              color: ColorStyles.primaryGrayBlue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Lorem ipsum dolor sit amet consectetur. Turpis enim feugiat egestas tellus amet. Tincidunt tincidunt aenean eget placerat. Proin risus enim sed velit. Lorem ipsum dolor sit amet consectetur. Turpis enim feugiat egestas tellus amet. Tincidunt tincidunt aenean eget placerat. Proin risus enim sed velit.',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              color: ColorStyles.primaryGrayBlue),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: eventCategoryLabel(),
                        ),
                        Row(
                          children: const [
                            Icon(
                              Icons.schedule,
                              color: ColorStyles.primaryBlue,
                              size: 20,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                '12/06/2024',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                    color: ColorStyles.primaryGrayBlue),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Empresas colaboradoras',
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: ColorStyles.primaryGrayBlue),
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            enableInfiniteScroll: false,
                            viewportFraction: 1,
                          ),
                          items: [
                            for (int index = 0; index < 3; index++)
                              Builder(
                                builder: (BuildContext context) {
                                  return providerWidget(context);
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Imágenes del evento',
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              color: ColorStyles.primaryGrayBlue),
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            enableInfiniteScroll: false,
                          ),
                          items: [
                            for (int index = 0; index < 3; index++)
                              Builder(
                                builder: (BuildContext context) {
                                  // return Image.file(i);
                                  return Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        Images.providerDetailPlaceholder,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  eventOptionButton(context, 'Eliminar evento')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
