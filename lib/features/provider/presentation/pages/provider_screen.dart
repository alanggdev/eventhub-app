import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/provider.dart';

class ProviderScreen extends StatefulWidget {
  const ProviderScreen({super.key});

  @override
  State<ProviderScreen> createState() => _ProviderScreenState();
}

class _ProviderScreenState extends State<ProviderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.primaryBlue,
      body: SafeArea(
        child: Container(
          color: ColorStyles.baseLightBlue,
          child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 55,
                backgroundColor: ColorStyles.primaryBlue,
                title: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_back_ios,
                          color: ColorStyles.white,
                          size: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Regresar',
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        color: ColorStyles.primaryBlue,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          child: Image.asset(
                            Images.providerDetailPlaceholder,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 15,
                        decoration: BoxDecoration(
                          color: ColorStyles.baseLightBlue,
                          border: Border.all(color: ColorStyles.baseLightBlue),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'Proveedor',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorStyles.primaryGrayBlue,
                              fontSize: 26,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            'Lorem ipsum dolor sit amet consectetur. Turpis enim feugiat egestas tellus amet. Tincidunt tincidunt aenean eget placerat. Proin risus enim sed velit. Lorem ipsum dolor sit amet consectetur. Turpis enim feugiat egestas tellus amet. Tincidunt tincidunt aenean eget placerat. Proin risus enim sed velit.',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: ColorStyles.primaryGrayBlue,
                              fontSize: 16,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        providerCategoryLabel(),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            children: [
                              providerInfo(Icons.phone, '961 123 1234'),
                              providerInfo(Icons.mail, 'correo@mail.com'),
                              providerInfo(Icons.schedule,
                                  'Lunes a Viernes: 9AM - 6PM '),
                              providerInfo(
                                  Icons.location_on, 'Av. Ejemplo #123'),
                            ],
                          ),
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            enableInfiniteScroll: false,
                          ),
                          items: [
                            for (int index = 0; index < 3; index++)
                              Builder(
                                builder: (BuildContext context) {
                                  // return Image.file(i);
                                  return Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        Images.providerDetailPlaceholder,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                      ),
                                    ),
                                  );
                                },
                              ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            providerOptionButton(context, 'Invitar a evento'),
                            providerOptionButton(context, 'Contactar'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
