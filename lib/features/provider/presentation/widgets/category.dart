import 'package:flutter/material.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/provider/presentation/pages/category_provider.dart';

List<Map<String, dynamic>> allCategories = [
  {
    'id': 1,
    'image': Images.categoryPlaceholder,
    'category': 'Locación',
    'description': 'Lugares, salones y espacios'
  },
  {
    'id': 2,
    'image': Images.categoryPlaceholder,
    'category': 'Ambiente y Decoración',
    'description': 'Ambiente temático y decoración creativa'
  },
  {
    'id': 3,
    'image': Images.categoryPlaceholder,
    'category': 'Comunicación y Promoción',
    'description': 'Publicidad y promoción del evento'
  },
  {
    'id': 4,
    'image': Images.categoryPlaceholder,
    'category': 'Vestuario y Estilo',
    'description': 'Ropa y estilo de los participantes'
  },
  {
    'id': 5,
    'image': Images.categoryPlaceholder,
    'category': 'Alimentos y Bebidas',
    'description': 'Catering y opciones de bebidas'
  },
  {
    'id': 6,
    'image': Images.categoryPlaceholder,
    'category': 'Entretenimiento',
    'description': 'Actividades y shows para los asistentes'
  },
  {
    'id': 7,
    'image': Images.categoryPlaceholder,
    'category': 'Organización',
    'description': 'Planificación y logística del evento'
  },
  {
    'id': 8,
    'image': Images.categoryPlaceholder,
    'category': 'Seguridad y Emergencias',
    'description': 'Medidas de seguridad y protocolos de emergencia'
  },
  {
    'id': 9,
    'image': Images.categoryPlaceholder,
    'category': 'Fotografía y video',
    'description': 'Cobertura fotográfica y videográfica del evento'
  },
];

Padding categoryWidget(
    BuildContext context, String image, String category, String description) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    child: GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CategoryProvider(category, description)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
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
          child: Column(
            children: [
              Image.asset(
                image,
                width: MediaQuery.of(context).size.width * 0.25,
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  category,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ColorStyles.textPrimary2,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: ColorStyles.textPrimary1,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
