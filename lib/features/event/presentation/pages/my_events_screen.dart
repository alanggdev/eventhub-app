import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/event/presentation/widgets/event.dart';
import 'package:eventhub_app/features/event/presentation/pages/create_event_screen.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/event/presentation/bloc/event_bloc.dart';

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
    context.read<EventBloc>().add(GetUserEvents(userid: widget.user.userinfo['pk']));
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
                  Column(
                    children: [
                      if (state is Error)
                        errorWidget(context, state.error.substring(11)),
                      if (state is UserEventGotten)
                        if (state.userEvents.isNotEmpty)
                          Column(
                            children: state.userEvents.map((userEvent) {
                              return eventWidget(context, userEvent, widget.user);
                            }).toList(),
                          )
                        else
                          Center(child: emptyWidget(context, 'No tienes eventos próximos', Images.emptyEvents)),
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
        ],
      );
    });
  }
}
