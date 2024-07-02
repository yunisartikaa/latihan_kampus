import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/model_kampus.dart';


class PageDetail extends StatefulWidget {
  final Datum? data;
  const PageDetail(this.data, {Key? key}) : super(key: key);

  @override
  State<PageDetail> createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data; // Mengakses data dari widget

    // Mengonversi lat dan long dari String ke double
    double latitude = double.tryParse(data?.latKampus ?? '0.0') ?? 0.0;
    double longitude = double.tryParse(data?.longKampus ?? '0.0') ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Kampus"),
        backgroundColor: Colors.cyan,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 4, right: 4),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                data != null ? 'http://192.168.163.97/lat_kampus_apps/gambar/${data.gambarKampus}' : '',
                fit: BoxFit.fill,
              ),
            ),
          ),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data?.namaKampus ?? "",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 10,),
                Text('Alamat'),
                Text(
                  data?.lokasiKampus ?? "",
                  style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                ),
                SizedBox(height: 10,),
                Text('Profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              ],
            ),
            trailing: const Icon(
              Icons.star,
              color: Colors.red,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 16, bottom: 16, left: 16),
            child: Text(
              data?.profileKampus ?? "",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(height: 10,),
          Text('Lokasi',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 10,),
          // IconButton(
          //   onPressed: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(
          //     //     builder: (_) => MapPage(latitude, longitude),
          //     //   ),
          //     );
          //   },
          //   icon: Icon(Icons.arrow_back),
          // ),
          Container(
            height: 300, // Tentukan tinggi untuk GoogleMap
            child: GoogleMap(
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: LatLng(latitude, longitude),
                zoom: 16,
              ),
              mapType: MapType.normal,
              markers: {
                Marker(
                  markerId: MarkerId(data?.namaKampus ?? "Marker"),
                  position: LatLng(latitude, longitude),
                  infoWindow: InfoWindow(
                    title: data?.namaKampus ?? "",
                    snippet: data?.lokasiKampus ?? "",
                  ),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}