import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/event/presentation/widgets/event.dart';
import 'package:eventhub_app/features/event/presentation/pages/create_event_screen.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:eventhub_app/features/event/presentation/widgets/alerts.dart';

class MyEventsScreen extends StatefulWidget {
  final User user;
  const MyEventsScreen(this.user, {super.key});

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<EventBloc>()
        .add(GetUserEvents(userid: widget.user.userinfo['pk']));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(builder: (context, state) {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: ColorStyles.baseLightBlue,
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
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Mis eventos',
                          style: TextStyle(
                            color: ColorStyles.primaryGrayBlue,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      if (state is UserEventGotten)
                        if (state.userEvents.isNotEmpty)
                          Column(
                            children: state.userEvents.map((userEvent) {
                              return eventWidget(context, userEvent);
                            }).toList(),
                          )
                        else
                          emptyEventWidget(context),
                    ],
                  ),
                ],
              ),
            ),
            floatingActionButton: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Hero(
                    tag: 'refreshButton',
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: FloatingActionButton(
                        heroTag: null,
                        onPressed: () {
                          final evenyBloc = context.read<EventBloc>();
                          evenyBloc.add(GetUserEvents(
                              userid: widget.user.userinfo['pk']));
                        },
                        backgroundColor: ColorStyles.primaryBlue,
                        child: const Icon(
                          Icons.refresh,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                Hero(
                  tag: 'addButton',
                  child: FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CreateEventScreen(widget.user)));
                    },
                    backgroundColor: ColorStyles.primaryBlue,
                    child: const Icon(
                      Icons.add,
                      size: 45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // if (state is GettingUserEvents)
          //   const Center(child: CircularProgressIndicator()),
        ],
      );
    });
  }
}
