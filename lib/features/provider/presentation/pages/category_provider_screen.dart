import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/assets.dart';

import 'package:eventhub_app/features/provider/presentation/widgets/provider.dart';
import 'package:eventhub_app/features/provider/presentation/bloc/provider_bloc.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/alerts.dart';

import 'package:eventhub_app/features/provider/domain/entities/provider.dart';

class CategoryProviderScreen extends StatefulWidget {
  final String categoryName, categoryDescription;
  const CategoryProviderScreen(this.categoryName, this.categoryDescription, {super.key});

  @override
  State<CategoryProviderScreen> createState() => _CategoryProviderScreenState();
}

class _CategoryProviderScreenState extends State<CategoryProviderScreen> {
  List<Provider> categoryProvider = [];

  @override
  void initState() {
    super.initState();
    context
        .read<ProviderBloc>()
        .add(GetCategoryProviders(category: widget.categoryName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.primaryBlue,
      body: BlocBuilder<ProviderBloc, ProviderState>(
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                Container(
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
                                border: Border.all(
                                    color: ColorStyles.baseLightBlue),
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
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                    Text(
                                      widget.categoryDescription,
                                      style: const TextStyle(
                                        color: ColorStyles.textSecondary2,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Inter',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (state is Error)
                            errorProviderWidget(context, state.error.substring(11)),
                          if (state is! CategoryProvidersLoaded && categoryProvider.isNotEmpty)
                            Column(
                              children: categoryProvider.map((provider) {
                                return providerWidget(context, provider);
                              }).toList(),
                            ),
                          if (state is CategoryProvidersLoaded)
                            if (state.categoryProviders.isNotEmpty)
                              FutureBuilder(
                                future: Future.delayed(Duration.zero, () async {
                                  setState(() {
                                    categoryProvider = state.categoryProviders;
                                  });
                                }),
                                builder: (context, snapshot) {
                                  return Column(
                                    children: categoryProvider.map((provider) {
                                      return providerWidget(context, provider);
                                    }).toList(),
                                  );
                                },
                              )
                            else if (state.categoryProviders.isEmpty)
                              emptyProviderCategoryWidget(context)
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is LoadingCategoryProviders)
                  loadingProviderWidget(context)
                // else if (state is Error)
                //   errorProviderAlert(context, state.error)
              ],
            ),
          );
        },
      ),
    );
  }
}
