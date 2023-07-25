import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/event/presentation/widgets/event.dart';
import 'package:eventhub_app/features/event/domain/entities/event.dart';
import 'package:eventhub_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:eventhub_app/features/event/presentation/widgets/alerts.dart';
import 'package:eventhub_app/home.dart';

import 'package:eventhub_app/features/auth/domain/entities/user.dart';

class EventScreen extends StatefulWidget {
  final Event userEvent;
  final User user;
  const EventScreen(this.userEvent, this.user, {super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  int currentIndexGalley = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.primaryBlue,
      body: BlocBuilder<EventBloc, EventState>(builder: (context, state) {
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
                      actions: [
                        options(context, widget.userEvent.id!, widget.userEvent.userID == widget.user.userinfo['pk'] ? 'User' : 'Provider'),
                      ],
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
                                widget.userEvent.name,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.userEvent.description,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  color: ColorStyles.primaryGrayBlue,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Wrap(
                                    spacing: 8,
                                    children:
                                        widget.userEvent.categories.map((category) {
                                      return eventCategoryLabel(category);
                                    }).toList(),
                                    //
                                  ),
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
                                    padding: const EdgeInsets.symmetric(horizontal: 6),
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
                              // === //
                              // Empresas que colaborran si existen
                              // === //
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Imágenes del evento ${currentIndexGalley+1}/${widget.userEvent.imagePaths!.length}',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w500,
                                        color: ColorStyles.primaryGrayBlue),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: CarouselSlider(
                                        options: CarouselOptions(
                                          enableInfiniteScroll: false, viewportFraction: 1,
                                          onPageChanged: (index, reason) {
                                            setState(() {
                                              currentIndexGalley = index;
                                            });
                                          }
                                        ),
                                        items: [
                                          for (int index = 0; index < widget.userEvent.imagePaths!.length; index++)
                                            Builder(
                                              builder: (BuildContext context) {
                                                return eventImage(widget.userEvent.imagePaths![index]);
                                              },
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
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
              if (state is DeletingUserEvent || state is RemovingProvider)
                loading(context)
              else if (state is UserEventDeleted || state is ProviderRemoved)
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
            ]
          ),
        );
      }),
    );
  }
}
