import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/provider/domain/entities/service.dart';
import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:eventhub_app/features/provider/presentation/pages/provider_screen.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/text_field.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/provider.dart';
import 'package:eventhub_app/features/provider/presentation/pages/service_screen.dart';
import 'package:eventhub_app/features/provider/presentation/pages/edit/edit_service_screen.dart';

class ServiceListScreen extends StatefulWidget {
  final Provider providerData;
  final List<Service> servicesData;
  final int userid;
  const ServiceListScreen(this.providerData, this.servicesData, this.userid, {super.key});

  @override
  State<ServiceListScreen> createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  Provider? provider;
  List<Service> services = [];
  int? userid;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    provider = widget.providerData;
    services = widget.servicesData;
    userid = widget.userid;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ProviderScreen(null, widget.providerData.userid)),
            (Route<dynamic> route) => route.isFirst,
          );
        return false;
      },
      child: Scaffold(
        backgroundColor: ColorStyles.baseLightBlue,
        appBar: AppBar(
          backgroundColor: ColorStyles.baseLightBlue,
          automaticallyImplyLeading: false,
          elevation: 0,
          toolbarHeight: 60,
          title: TextButton.icon(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: ColorStyles.primaryGrayBlue,
              size: 15,
            ),
            label: const Text(
              'Regresar',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Inter',
                color: ColorStyles.primaryGrayBlue,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textInterW600('Servicios de la empresa'),
                  const Divider(color: ColorStyles.baseLightBlue),
                  Column(
                    children: services.map((service) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: GestureDetector(
                          onTap: () {
                            if (userid == provider!.userid) {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditServiceScreen(service, provider!.providerId!, provider!.userid)));
                            } else {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceScreen(service)));
                            }
                          },
                          child: providerServiceWidget(context, service)
                        ),
                      );
                    },).toList()
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: userid == provider!.userid
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => EditServiceScreen(null, provider!.providerId!, provider!.userid)));
              },
              backgroundColor: ColorStyles.primaryBlue,
              child: const Icon(
                Icons.add,
                size: 45,
              ),
          ) : Container()
      ),
    );
  }
}
