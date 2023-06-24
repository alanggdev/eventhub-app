import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/provider.dart';

class CategoryProvider extends StatefulWidget {
  final String categoryName, categoryDescription;
  const CategoryProvider(this.categoryName, this.categoryDescription, {super.key});

  @override
  State<CategoryProvider> createState() => _CategoryProviderState();
}

class _CategoryProviderState extends State<CategoryProvider> {
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
                toolbarHeight: 70,
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
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.categoryName,
                              style: const TextStyle(
                                color: ColorStyles.primaryGrayBlue,
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                            Text(
                              widget.categoryDescription,
                              style: const TextStyle(
                                color: ColorStyles.textSecondary2,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  providerWidget(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
