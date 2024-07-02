import 'package:flutter/material.dart';
import 'package:kampusapp/screen_page/page_maps_all.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu Apps'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Beranda'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapsAllPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Maps Sekolah'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapsAllPage()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Selamat Datang di Aplikasi Kampus'),
      ),
    );
  }
}