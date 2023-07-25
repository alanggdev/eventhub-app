import 'package:eventhub_app/assets.dart';
import 'package:flutter/material.dart';

import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/event/presentation/pages/my_events_screen.dart';
import 'package:eventhub_app/features/event/presentation/pages/provider_events_screen.dart';

class HomeEvents extends StatefulWidget {
  final User user;
  const HomeEvents(this.user, {super.key});

  @override
  State<HomeEvents> createState() => _HomeEventsState();
}

class _HomeEventsState extends State<HomeEvents> with TickerProviderStateMixin {
  late final TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: ColorStyles.primaryBlue,
          child: Container(
            decoration: BoxDecoration(
              color: ColorStyles.baseLightBlue,
              border: widget.user.userinfo['is_provider'] ? Border.all(color: ColorStyles.primaryDarkBlue) : Border.all(color: ColorStyles.baseLightBlue),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(22),
                topRight: Radius.circular(22),
              ),
            ),
            child: widget.user.userinfo['is_provider'] ?
            TabBar(
              controller: _tabController,
              indicatorColor: ColorStyles.primaryDarkBlue,
              labelColor: ColorStyles.primaryBlue,
              labelStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Inter',
              ),
              tabs: const <Widget>[
                Tab(text: 'Mis eventos'),
                Tab(text: 'Colaboraciones'),
              ],
            )
            : 
            IgnorePointer(
              ignoring: true,
              child: TabBar(
                controller: _tabController,
                indicatorColor: ColorStyles.baseLightBlue,
                labelColor: ColorStyles.primaryBlue,
                labelStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Inter',
                ),
                tabs: const <Widget>[
                  Tab(text: 'Mis eventos'),
                  Tab(text: ''),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              MyEventsScreen(widget.user),
              ProviderEventsScreen(widget.user),
            ],
          ),
        ),
      ],
    );
  }
}