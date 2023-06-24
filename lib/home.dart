import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/event/presentation/pages/my_events_screen.dart';
import 'package:eventhub_app/features/auth/presentation/pages/auth_screen.dart';

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
                    onPressed: () {
                      showModalBottomSheet<void>(
                        barrierColor: const Color.fromARGB(127, 79, 84, 150),
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 310,
                              child: Center(
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  // mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 10),
                                      child: Row(
                                        children: [
                                          Center(
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    blurRadius: 5,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                                image: const DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: AssetImage(
                                                        Images.logoURL)),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  'Alan Gómez Gómez',
                                                  style: TextStyle(
                                                    fontSize: 23,
                                                    color: Color(0xff242C71),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(top: 12),
                                                  child: Text(
                                                    '@IzLightG',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Color(0xff242C71),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      color: Color(0xff3B47B6),
                                    ),
                                    menuOption(context, 'Mi perfil',
                                        CustomIcons.profilePlaceholder),
                                    menuOption(context, 'Mi empresa',
                                        CustomIcons.companyPlaceholder),
                                    logoutButton(context)
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
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

  Padding logoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: ColorStyles.secondaryColor1,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadowColor: Colors.black,
          elevation: 6,
        ),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const AuthScreen()),
              (route) => false);
        },
        child: const Text(
          'Cerrar Sesión',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  Padding menuOption(
      BuildContext context, String label, String profilePlaceholder) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Center(
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage(profilePlaceholder)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 23,
                color: Color(0xff242C71),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
