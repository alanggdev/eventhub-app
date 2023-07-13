import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({
    super.key,
    required this.initialLocation,
    this.mapSize = const Size(300, 300),
  });

  final LatLng initialLocation;
  final Size mapSize;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
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
    return FlutterMap(
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
        MarkerLayer(
          markers: [
            Marker(
              point: widget.initialLocation,
              builder: (_) => const Icon(Icons.location_on, color: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}
