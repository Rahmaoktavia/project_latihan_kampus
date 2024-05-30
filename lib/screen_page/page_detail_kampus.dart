import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project_latihan_kampus/screen_page/page_maps.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Model/model_kampus.dart';


class KampusDetail extends StatelessWidget {
  final Datum kampus;

  KampusDetail({required this.kampus});

  @override
  Widget build(BuildContext context) {
    double? latitude = double.tryParse(kampus.lat);
    double? longitude = double.tryParse(kampus.long);

    return Scaffold(
      appBar: AppBar(
        title: Text(kampus.nama),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'http://192.168.156.142/project_kampus/gambar/${kampus.gambar}',
                width: double.infinity,
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              kampus.nama,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              kampus.lokasi,
              style: TextStyle(fontSize: 18, color: Colors.grey[700]),
            ),
            SizedBox(height: 8.0),
            Text(
              kampus.profile,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(Icons.location_pin, color: Colors.red),
                SizedBox(width: 8.0),
                Text('Lokasi'),
              ],
            ),
            SizedBox(height: 8.0),
            GestureDetector(
              onTap: () {
                _launchMapsUrl(context, latitude ?? 0.0, longitude ?? 0.0);
              },
              child: Container(
                height: 300,
                child: GoogleMap(
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(latitude ?? 0.0, longitude ?? 0.0),
                    zoom: 16,
                  ),
                  mapType: MapType.normal,
                  markers: {
                    Marker(
                      markerId: MarkerId(kampus.nama),
                      position: LatLng(latitude ?? 0.0, longitude ?? 0.0),
                      infoWindow: InfoWindow(
                        title: kampus.nama,
                        snippet: kampus.lokasi,
                      ),
                    ),
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _launchMapsUrl(BuildContext context, double latitude, double longitude) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapsFlutter(
          latitude: latitude,
          longitude: longitude,
          namaKampus: kampus.nama,
        ),
      ),
    );
  }
}
