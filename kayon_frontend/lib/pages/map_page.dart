import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kayon_frontend/classes/colors.dart';
import 'package:kayon_frontend/components/background.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class AddressMap extends StatefulWidget {final bool showAppbar;
   const AddressMap({ super.key, required this.showAppbar });
  @override
  _AddressMapState createState() => _AddressMapState();
}

class _AddressMapState extends State<AddressMap> {
  LatLng? _markerPosition;
  final TextEditingController _addressController = TextEditingController();
Future<LatLng> getLatLngFromAddress(String address) async {
  final url = Uri.parse(
    'https://nominatim.openstreetmap.org/search?q=$address&format=json',
  );

  final response = await http.get(url);
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data.isNotEmpty) {
      final lat = double.parse(data[0]['lat']);
      final lon = double.parse(data[0]['lon']);
      return LatLng(lat, lon);
    } else {
      throw Exception('No results found for the address');
    }
  } else {
    throw Exception('Failed to fetch data');
  }
}
  Future<void> _searchAddress() async {
    final address = _addressController.text;
    if (address.isNotEmpty) {
      try {
        final latLng = await getLatLngFromAddress(address);
        setState(() {
          _markerPosition = latLng;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:!widget.showAppbar?null: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "Magazins",
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontSize: 20,
              letterSpacing: 0.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color(AppColors.orange_primary),
        ),
      body:
       size.width > 600
            ? NewBackground(
                child: Container(
                    alignment: Alignment.center,
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width > 600 ? 600 : null,
                        constraints: BoxConstraints(maxWidth: 600),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red)),
                        child: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(34.013312,-6.851938), // Default center
                zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                  MarkerLayer(
                    markers: [
                       Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(34.013312,-6.851938),
                        builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      ), Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(34.008750,-6.853750),
                        builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    ))):Container(
                    alignment: Alignment.center,
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width > 600 ? 600 : null,
                        constraints: BoxConstraints(maxWidth: 600),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red)),
                        child: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(34.013312,-6.851938), // Default center
                zoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                  MarkerLayer(
                    markers: [
                       Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(34.013312,-6.851938),
                        builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      ), Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(34.008750,-6.853750),
                        builder: (ctx) => const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40.0,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}