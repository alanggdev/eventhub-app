import 'package:eventhub_app/features/auth/presentation/widgets/text_field.dart';
import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';

class CreateCompanyScreen extends StatefulWidget {
  const CreateCompanyScreen({super.key});

  @override
  State<CreateCompanyScreen> createState() => _CreateCompanyScreenState();
}

class _CreateCompanyScreenState extends State<CreateCompanyScreen> {
  final companyNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final phoneController = TextEditingController();
  final companyEmailController = TextEditingController();
  final addressController = TextEditingController();

  List<String> selectedOptions = [];
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.baseLightBlue,
      appBar: AppBar(
        backgroundColor: ColorStyles.baseLightBlue,
        automaticallyImplyLeading: false,
        elevation: 0,
        toolbarHeight: 80,
        title: Padding(
          padding: const EdgeInsets.all(15),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.05,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.arrow_back_ios,
                    color: ColorStyles.primaryGrayBlue,
                    size: 20,
                  ),
                  Text(
                    'Mi empresa',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: ColorStyles.primaryGrayBlue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            textFieldFormCompany(
                context, 'Nombre de la empresa', companyNameController),
            textFieldFormCompany(
                context, 'Descripción general', companyNameController),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorStyles.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 3)),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          'Categorías:',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            color: ColorStyles.secondaryColor3,
                          ),
                        ),
                      ),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            underline: const SizedBox(),
                            onChanged: (String? newValue) {
                              setState(() {
                                if (!selectedOptions.contains(newValue)) {
                                  dropdownValue = newValue;
                                  selectedOptions.add(newValue!);
                                }
                              });
                            },
                            items: <String>[
                              'Alimentos',
                              'Audio',
                              'Entretenimiento',
                              'Vestuario',
                              'Locación',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Wrap(
              spacing: 8.0,
              children: selectedOptions.map((option) {
                return Chip(
                  backgroundColor: ColorStyles.primaryBlue,
                  labelStyle: const TextStyle(
                    color: ColorStyles.baseLightBlue,
                    fontFamily: 'Inter',
                  ),
                  label: Text(option),
                  deleteIcon: const Icon(
                    Icons.delete,
                    color: ColorStyles.baseLightBlue,
                    size: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        10.0), // Cambia el radio de los bordes
                  ),
                  onDeleted: () {
                    setState(() {
                      selectedOptions.remove(option);
                    });
                  },
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Text(
                    'Imagenes',
                    style: TextStyle(
                        color: ColorStyles.textPrimary2,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 25),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        print('object');
                      },
                      child: Container(
                        height: 28,
                        width: 28,
                        decoration: const BoxDecoration(
                          color: ColorStyles.primaryBlue,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: ColorStyles.baseLightBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
