import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/event/presentation/widgets/event.dart';
import 'package:eventhub_app/features/event/presentation/pages/create_event_screen.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/event/presentation/bloc/event_bloc.dart';

class MyEventsScreen extends StatefulWidget {
  final User userinfo;
  const MyEventsScreen(this.userinfo, {super.key});

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.baseLightBlue,
      body: BlocBuilder<EventBloc, EventState>(builder: (context, state) {
        return SingleChildScrollView(
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
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 30),
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Image.asset(
              //         Images.emptyEvents,
              //         width: MediaQuery.of(context).size.width * 0.8,
              //       ),
              //       const Text(
              //         'No tienes eventos próximos',
              //         style: TextStyle(
              //           color: ColorStyles.primaryGrayBlue,
              //           fontSize: 20,
              //           fontWeight: FontWeight.w500,
              //           fontFamily: 'Inter',
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              Column(
                children: [
                  eventWidget(context)
                ],
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateEventScreen(
                      widget.userinfo)));
        },
        backgroundColor: ColorStyles.primaryBlue,
        child: const Icon(
          Icons.add,
          size: 45,
        ),
      ),
    );
  }
}
