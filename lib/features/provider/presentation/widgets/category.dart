import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/provider/presentation/pages/category_provider_screen.dart';

import 'package:eventhub_app/features/auth/domain/entities/user.dart';

List<Map<String, dynamic>> allCategories = [
  {
    'id': 1,
    'image': Images.locacion,
    'name': 'Locación',
    'description': 'Lugares, salones y espacios'
  },
  {
    'id': 2,
    'image': Images.ambiente,
    'name': 'Ambiente y Decoración',
    'description': 'Ambiente temático y decoración creativa'
  },
  {
    'id': 3,
    'image': Images.comunicacion,
    'name': 'Comunicación y Promoción',
    'description': 'Publicidad y promoción del evento'
  },
  {
    'id': 4,
    'image': Images.vestuario,
    'name': 'Vestuario y Estilo',
    'description': 'Ropa y estilo de los participantes'
  },
  {
    'id': 5,
    'image': Images.alimentos,
    'name': 'Alimentos y Bebidas',
    'description': 'Catering y opciones de bebidas'
  },
  {
    'id': 6,
    'image': Images.entretenimiento,
    'name': 'Entretenimiento',
    'description': 'Actividades y shows para los asistentes'
  },
  {
    'id': 7,
    'image': Images.organizacion,
    'name': 'Organización',
    'description': 'Planificación y logística del evento'
  },
  {
    'id': 8,
    'image': Images.fotografia,
    'name': 'Fotografía y video',
    'description': 'Cobertura fotográfica y videográfica del evento'
  },
];

Padding categoryWidget(
    BuildContext context, String image, String category, String description, User user) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryProviderScreen(category, description, user)));
      },
      child: Container(
        width: double.infinity,
        height: 110,
        decoration: BoxDecoration(
          color: ColorStyles.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              blurRadius: 5,
              offset: const Offset(0, 0.5),
            ),
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
