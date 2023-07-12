import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/provider/presentation/widgets/category.dart';

import 'package:eventhub_app/features/auth/domain/entities/user.dart';

class ExploreCategoriesScreen extends StatefulWidget {
  final User user;
  const ExploreCategoriesScreen(this.user, {super.key});

  @override
  State<ExploreCategoriesScreen> createState() =>
      _ExploreCategoriesScreenState();
}

class _ExploreCategoriesScreenState extends State<ExploreCategoriesScreen> {
  List<Map<String, dynamic>> categoryList = allCategories;
  @override
  Widget build(BuildContext context) {
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
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Explorar',
                        style: TextStyle(
                          color: ColorStyles.primaryGrayBlue,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      Text(
                        'Busca entre nuestras categorías y encuentra a los mejores proveedores y empresas para hacer realidad tu evento.',
                        style: TextStyle(
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
            Wrap(
              children: categoryList.map((category) {
                return categoryWidget(context, category['image'], category['name'], category['description'], widget.user);
              },).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
