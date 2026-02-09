import 'package:evently_app/Ui/home/tabs/map_tab/provider/maps_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTab extends StatelessWidget {
  const MapTab({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MapsTabProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Choose Location")),
      body: GoogleMap(
        initialCameraPosition: provider.cameraPosition,
        onMapCreated: (controller) {
          provider.googleMapController = controller;
        },
        markers: provider.markers,
        onTap: (LatLng position) {
          provider.selectLocation(position);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "gps",
            onPressed: provider.getCurrentLocation,
            child: const Icon(Icons.gps_fixed),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "confirm",
            onPressed: () {
              if (provider.selectedLocation != null) {
                Navigator.pop(context, provider.selectedLocation);
              }
            },
            child: const Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}
