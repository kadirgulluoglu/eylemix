import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_solution_challenge/screens/home_screens/viewmodel/deprem_viewmodel.dart';
import 'package:latlong2/latlong.dart';

class SonDepremMaps extends StatefulWidget {
  final DepremViewModel viewModel;
  const SonDepremMaps({super.key, required this.viewModel});

  @override
  State<SonDepremMaps> createState() => _SonDepremMapsState();
}

class _SonDepremMapsState extends State<SonDepremMaps> {
  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    _loadMarkers();
  }

  void _loadMarkers() {
    final depremModel = widget.viewModel.depremModel;
    final results = depremModel?.result;

    if (results != null) {
      for (var result in results) {
        if (result.geojson != null && result.geojson!.coordinates != null) {
          final coords = result.geojson!.coordinates!;
          if (coords.length >= 2) {
            final marker = Marker(
              width: 20.0,
              height: 20.0,
              point: LatLng(coords[1], coords[0]), // lat long koordinatları
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            );
            markers.add(marker);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recent Earthquakes on Map"),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(38.9637, 35.2433),
          initialZoom: 5.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: markers,
          ),
        ],
      ),
    );
  }
}
