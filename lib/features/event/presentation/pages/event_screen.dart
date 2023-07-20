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
                        if (widget.userEvent.userID == widget.user.userinfo['pk']) 
                          options(context),
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
              if (state is DeletingUserEvent)
                loading(context)
              else if (state is UserEventDeleted)
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

  PopupMenuButton<String> options(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert, color: ColorStyles.white, size: 28),
      onSelected: (value) {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
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
                              fontSize: 20),
                        ),
                      ),
                      Text(
                        'Una vez eliminado la información del servicio no podrá ser recuperada.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorStyles.warningCancel,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                            fontSize: 16),
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
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.3, 40),
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
                    minimumSize:
                        Size(MediaQuery.of(context).size.width * 0.3, 40),
                    foregroundColor: Colors.white,
                    backgroundColor:
                        ColorStyles.primaryGrayBlue.withOpacity(0.75),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadowColor: Colors.black,
                    elevation: 3,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    context
                        .read<EventBloc>()
                        .add(DeleteUserEvent(eventid: widget.userEvent.id!));
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
    );
  }
}
