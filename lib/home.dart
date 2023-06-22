import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/event/presentation/pages/my_events_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    MyEventsScreen(),
    MyEventsScreen(),
    MyEventsScreen(),
    MyEventsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.primaryBlue,
      // body: SafeArea(
      //   child: Center(
      //     child: _widgetOptions.elementAt(_selectedIndex),
      //   ),
      // ),
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 70,
              backgroundColor: ColorStyles.primaryBlue,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Image.asset(
                      Images.logoURL,
                      width: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'eventhub',
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Righteous',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      size: 25,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
          body: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        child: BottomAppBar(
          color: ColorStyles.white,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  onPressed: () {
                    _onItemTapped(0);
                  },
                  // minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                          _selectedIndex == 0
                              ? CustomIcons.homeFilled
                              : CustomIcons.homeOutlined,
                          color: _selectedIndex == 0
                              ? ColorStyles.secondaryColor1
                              : ColorStyles.secondaryColor3,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    _onItemTapped(1);
                  },
                  // minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                          _selectedIndex == 1
                              ? CustomIcons.providersFilled
                              : CustomIcons.providersOutlined,
                          color: _selectedIndex == 1
                              ? ColorStyles.secondaryColor1
                              : ColorStyles.secondaryColor3,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    _onItemTapped(2);
                  },
                  // minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                          _selectedIndex == 2
                              ? CustomIcons.messagesFilled
                              : CustomIcons.messagesOutlined,
                          color: _selectedIndex == 2
                              ? ColorStyles.secondaryColor1
                              : ColorStyles.secondaryColor3,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    _onItemTapped(3);
                  },
                  // minWidth: 40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                          _selectedIndex == 3
                              ? CustomIcons.notificationsFilled
                              : CustomIcons.notificationsOutlined,
                          color: _selectedIndex == 3
                              ? ColorStyles.secondaryColor1
                              : ColorStyles.secondaryColor3,
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
    );
  }
}
