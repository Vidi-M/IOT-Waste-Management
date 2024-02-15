import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iot_app/pages/add_bin_page.dart';
import 'package:iot_app/pages/home_page.dart';
import 'package:firebase_database/firebase_database.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const LatLng _pImperial = LatLng(51.498611, -0.174833);
  late DatabaseReference dbRef;
  Set<Marker> binMarkers = {};

  void fetchMarkers() async {
    print("fetching data");
    DataSnapshot snapshot = await dbRef.get();
    Map<dynamic, dynamic> bin = snapshot.value as Map;
    print(bin);

    List<LatLng> coordinates = [];
    List<String> names = [];

    bin.forEach((key, value) {
      names.add(value["binName"]);
      double lat = double.parse(value["lat"]);
      double lng = double.parse(value['lng']);
      coordinates.add(LatLng(lat, lng));
    });

    print(coordinates);

    for (int i = 0; i < coordinates.length; i++) {
      binMarkers.add(
        Marker(
          markerId: MarkerId(names[i]),
          icon: BitmapDescriptor.defaultMarker,
          position: coordinates[i],
          // You can customize other properties of the marker here
          // For example: icon, infoWindow, etc.
        )
      );
    }

  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    dbRef = FirebaseDatabase.instance.ref().child("Bins");
    fetchMarkers();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title:
          Row(
            children: [
              GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBinPage(),
                  ),
                // Handle button press
              ),
              child: Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue, // Replace with appropriate colors
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),

            const Spacer(),

            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                  ),
                // Handle button press
              ),
              child: Container(
                width: 40,
                height: 40,
                margin: const EdgeInsets.only(left: 10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue, // Replace with appropriate colors
                ),
                child: const Icon(
                  Icons.list,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      body: GoogleMap(
        markers: binMarkers,
        initialCameraPosition: CameraPosition(
          target: _pImperial,
          zoom:13,
        ), 
      ) ,
    );
  }
}