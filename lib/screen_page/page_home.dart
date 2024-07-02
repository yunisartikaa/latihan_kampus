import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kampusapp/screen_page/page_detail_kampus.dart';
import '../model/model_kampus.dart';

class PageBeranda extends StatefulWidget {
  const PageBeranda({super.key});

  @override
  State<PageBeranda> createState() => _PageBerandaState();
}

class _PageBerandaState extends State<PageBeranda> {
  TextEditingController searchController = TextEditingController();
  List<Datum>? kampusList;
  List<Datum>? filteredKampusList;

  // Method untuk get kampus
  Future<void> getKampus() async {
    try {
      http.Response response = await http
          .get(Uri.parse('http://192.168.163.97/lat_kampus_apps/getKampus.php'));
      if (response.statusCode == 200) {
        setState(() {
          kampusList = modelKampusFromJson(response.body).data;
          filteredKampusList = kampusList;
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to load data')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void initState() {
    super.initState();
    getKampus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    filteredKampusList = kampusList
                        ?.where((element) =>
                    element.namaKampus!.toLowerCase().contains(value.toLowerCase()) ||
                        element.lokasiKampus!.toLowerCase().contains(value.toLowerCase()))
                        .toList();
                  });
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            Text(
              'Galeri',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Image.asset(
                  'gambar/kampus1.jpeg',
                  fit: BoxFit.contain,
                  height: 262,
                  width: 209,
                ),
                SizedBox(width: 10),
                Image.asset(
                  'gambar/kampus2.jpeg',
                  fit: BoxFit.contain,
                  height: 262,
                  width: 209,
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Welcome Kampus',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              'Padang Kota Tercinta',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(height: 10),
            kampusList == null
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: filteredKampusList!.length,
              itemBuilder: (context, index) {
                Datum data = filteredKampusList![index];
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PageDetail(data),
                        ),
                      );
                    },
                    child: Card(
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: 120,
                          maxWidth: 400,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'http://192.168.163.97/lat_kampus_apps/gambar/${data?.gambarKampus}',
                                  fit: BoxFit.cover,
                                  height: 76,
                                  width: 76,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.namaKampus!,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      // '${data.jarak} km',
                                      '1.5 km',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      data.lokasiKampus!,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}