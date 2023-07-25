import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/event/presentation/widgets/event.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/event/presentation/bloc/event_bloc.dart';

class ProviderEventsScreen extends StatefulWidget {
  final User user;
  const ProviderEventsScreen(this.user, {super.key});

  @override
  State<ProviderEventsScreen> createState() => _ProviderEventsScreenState();
}

class _ProviderEventsScreenState extends State<ProviderEventsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(GetProviderEvents(userid: widget.user.userinfo['pk']));
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
                      if (state is ProviderEventsLoaded)
                        if (state.providerEvents.isNotEmpty)
                          Column(
                            children: state.providerEvents.map((userEvent) {
                              return eventWidget(context, userEvent, widget.user);
                            }).toList(),
                          )
                        else
                          Center(child: emptyWidget(context, 'No tienes colaboraciones', Images.emptyEvents)),
                    ],
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<EventBloc>().add(GetProviderEvents(userid: widget.user.userinfo['pk']));
              },
              backgroundColor: ColorStyles.primaryBlue,
              child: const Icon(
                Icons.refresh,
                size: 40,
              ),
            ),
          ),
        ],
      );
    });
  }
}