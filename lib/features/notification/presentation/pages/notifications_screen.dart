import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/notification/presentation/widgets/notification.dart';
import 'package:eventhub_app/features/notification/presentation/bloc/notification_bloc.dart';

import 'package:eventhub_app/features/auth/domain/entities/user.dart';

class NotificationsScreen extends StatefulWidget {
  final User user;
  const NotificationsScreen(this.user, {super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  User? user;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    user = widget.user;
    context
        .read<NotificationBloc>()
        .add(GetNotifications(userid: user!.userinfo['pk']));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
      return Scaffold(
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
                      'Mis notificaciones',
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
              if (state is LoadingNotifications)
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: loading(context),
                ),
              if (state is NotificationsLoaded)
                if (state.notifications.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: Column(
                      children: [
                        notificationWidget(context),
                      ],
                    ),
                  )
                else if (state.notifications.isEmpty)
                  emptyWidget(context, 'No tienes notificaciones', Images.emptychat),
            ],
          ),
        ),
      );
    });
  }
}
