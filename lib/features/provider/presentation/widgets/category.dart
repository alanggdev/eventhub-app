import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/provider/presentation/pages/category_provider_screen.dart';

List<Map<String, dynamic>> allCategories = [
  {
    'id': 1,
    'image': Images.categoryPlaceholder,
    'name': 'Locación',
    'description': 'Lugares, salones y espacios'
  },
  {
    'id': 2,
    'image': Images.categoryPlaceholder,
    'name': 'Ambiente y Decoración',
    'description': 'Ambiente temático y decoración creativa'
  },
  {
    'id': 3,
    'image': Images.categoryPlaceholder,
    'name': 'Comunicación y Promoción',
    'description': 'Publicidad y promoción del evento'
  },
  {
    'id': 4,
    'image': Images.categoryPlaceholder,
    'name': 'Vestuario y Estilo',
    'description': 'Ropa y estilo de los participantes'
  },
  {
    'id': 5,
    'image': Images.categoryPlaceholder,
    'name': 'Alimentos y Bebidas',
    'description': 'Catering y opciones de bebidas'
  },
  {
    'id': 6,
    'image': Images.categoryPlaceholder,
    'name': 'Entretenimiento',
    'description': 'Actividades y shows para los asistentes'
  },
  {
    'id': 7,
    'image': Images.categoryPlaceholder,
    'name': 'Organización',
    'description': 'Planificación y logística del evento'
  },
  {
    'id': 8,
    'image': Images.categoryPlaceholder,
    'name': 'Seguridad y Emergencias',
    'description': 'Medidas de seguridad y protocolos de emergencia'
  },
  {
    'id': 9,
    'image': Images.categoryPlaceholder,
    'name': 'Fotografía y video',
    'description': 'Cobertura fotográfica y videográfica del evento'
  },
];

Padding categoryWidget(
    BuildContext context, String image, String category, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryProviderScreen(category, description)));
      },
      child: Container(
        width: double.infinity,
        height: 110,
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
          padding: const EdgeInsets.all(16),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  image,
                  width: 85,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: const TextStyle(
                              color: ColorStyles.textPrimary2,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              description,
                              style: const TextStyle(
                                color: ColorStyles.textPrimary1,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
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
            ),
          ),
        ),
      ),
    ),
  );
}
