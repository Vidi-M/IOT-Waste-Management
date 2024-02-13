import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iot_app/pages/add_bin_page.dart';
import 'package:iot_app/pages/home_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const LatLng _pImperial = LatLng(51.498611, -0.174833);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
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
        initialCameraPosition: CameraPosition(
          target: _pImperial,
          zoom:13,
        ),
        markers: {
          Marker(
            markerId: MarkerId("_currentLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: _pImperial)
        },
      ),
    );
  }
}