import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsFlutter extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String namaKampus;

  const MapsFlutter({
    Key? key,
    required this.latitude,
    required this.longitude,
    required this.namaKampus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(namaKampus),
        backgroundColor: Colors.deepPurple,
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        initialCameraPosition: const CameraPosition(
            target: LatLng(-0.9143318947370737, 100.46619390941406),
            zoom: 10)
        ,
        mapType: MapType.normal,
        markers: {
      const Marker(
      markerId: MarkerId("Politeknik Negeri Padang"),
      position: LatLng(-0.9143318947370737, 100.46619390941406
      ),infoWindow: InfoWindow(
      title: 'Politeknik Negeri Padang', snippet: 'Jl. Kampus, Limau Manis, Kec. Pauh, Kota Padang, Sumatera Barat 25164'
      ),
          ),
          const Marker(
            markerId: MarkerId("Universitas Andalas"),
            position: LatLng(-0.9149550574417532, 100.45818958057835
            ),infoWindow: InfoWindow(
              title: 'Universitas Andalas', snippet: 'Limau Manis, Kec. Pauh, Kota Padang, Sumatera Barat 25175'
          ),
          ),
          const Marker(
            markerId: MarkerId("Universitas Negeri Padang"),
            position: LatLng(-0.8964539712917985, 100.35077527615466
            ),infoWindow: InfoWindow(
              title: 'Universitas Negeri Padang', snippet: 'Jalan Prof. Dr. Hamka, Air Tawar, Kota Padang'
          ),
          ),
        },
      ),
    );
  }
}
