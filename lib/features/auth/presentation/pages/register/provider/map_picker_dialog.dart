import 'package:eventhub_app/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPickerDialog extends StatefulWidget {
  const MapPickerDialog({
    super.key,
    required this.initialLocation,
    this.mapSize = const Size(300, 300),
  });

  final LatLng initialLocation;
  final Size mapSize;

  @override
  State<MapPickerDialog> createState() => _MapPickerDialogState();
}

class _MapPickerDialogState extends State<MapPickerDialog> {
  final mapController = MapController();
  late final pickedLocation = ValueNotifier<LatLng>(widget.initialLocation);

  @override
  void dispose() {
    pickedLocation.dispose();
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Seleccionar ubicación'),
      content: SizedBox.fromSize(
        size: widget.mapSize,
        child: FlutterMap(
          mapController: mapController,
          options: MapOptions(
            center: widget.initialLocation,
            maxZoom: 17,
            zoom: 16.5,
            minZoom: 16,
            onMapReady: () => pickedLocation.value = mapController.center,
            onPositionChanged: (_, __) {
              pickedLocation.value = mapController.center;
            },
          ),
          children: [
            TileLayer(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
              additionalOptions: const {
                'accessToken': mapBoxToken,
                'id': 'mapbox/streets-v12'
              },
            ),
            ValueListenableBuilder<LatLng>(
              valueListenable: pickedLocation,
              builder: (context, location, _) {
                return MarkerLayer(
                  markers: [
                    Marker(
                      point: location,
                      builder: (_) => const Icon(Icons.location_on),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, pickedLocation.value),
          child: const Text('OK'),
        ),
      ],
      titlePadding: const EdgeInsets.all(15),
      contentPadding: const EdgeInsets.only(bottom: 2, left: 15, right: 15),
      actionsPadding: const EdgeInsets.only(bottom: 5),
    );
  }
}
