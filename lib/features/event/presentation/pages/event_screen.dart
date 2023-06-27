import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/event/presentation/widgets/event.dart';
import 'package:eventhub_app/features/event/domain/entities/event.dart';
import 'package:eventhub_app/features/event/presentation/widgets/button.dart';
import 'package:eventhub_app/keys.dart';

import 'package:eventhub_app/features/provider/presentation/widgets/provider.dart';

class EventScreen extends StatefulWidget {
  final Event userEvent;
  const EventScreen(this.userEvent, {super.key});

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
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        color: ColorStyles.primaryGrayBlue,
                        size: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          widget.userEvent.name,
                          style: const TextStyle(
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
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userEvent.description,
                          style: const TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              color: ColorStyles.primaryGrayBlue),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Wrap(
                            spacing: 8,
                            children:
                                widget.userEvent.categories.map((category) {
                              return eventCategoryLabel(category);
                            }).toList(),
                            //
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.schedule,
                              color: ColorStyles.primaryBlue,
                              size: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Text(
                                widget.userEvent.date,
                                style: const TextStyle(
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
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
                        const Divider(
                          color: ColorStyles.baseLightBlue,
                        ),
                        if (widget.userEvent.providersID.isNotEmpty)
                          CarouselSlider(
                            options: CarouselOptions(
                                enableInfiniteScroll: false,
                                viewportFraction: 1,
                                height: 250),
                            items: [
                              for (int index = 0; index < 3; index++)
                                Builder(
                                  builder: (BuildContext context) {
                                    return providerWidget(context);
                                  },
                                ),
                            ],
                          )
                        else
                          const Text(
                            'Aun no tiene empresas que colaboren',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                color: ColorStyles.primaryGrayBlue),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
                          options: CarouselOptions(enableInfiniteScroll: false),
                          items: [
                            for (int index = 0;
                                index < widget.userEvent.imagePaths!.length;
                                index++)
                              Builder(
                                builder: (BuildContext context) {
                                  return eventImage(
                                      widget.userEvent.imagePaths![index]);
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
