import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iot_app/pages/map_page.dart';
import 'components/find_location.dart';

class AddBinPage extends StatefulWidget {
  const AddBinPage({Key? key}) : super(key: key);

  @override
  State<AddBinPage> createState() => _AddBinPageState();
}

class _AddBinPageState extends State<AddBinPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _binNameController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  final LocationFinder location = LocationFinder();

  late DatabaseReference dbRef;
  List<String> nodes = [];


  Future<void> fetchNumBins() async {
    DataSnapshot snapshot = await dbRef.get();
    Map<dynamic, dynamic> bin = snapshot.value as Map;
    bin.forEach((key, value) {
      nodes.add(value['binName']);
    });
  }

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child("Bins");
    fetchNumBins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Bin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _binNameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Enter bin name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter bin name';
                    }
                    return null;
                  },
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      print("position is being found");
                      await location.getCurrentPosition();
                      setState(() {
                      });
                    },
                    child: const Text("Get Current Location"),
                  ),
                  //const SizedBox(height: 32),
                  Text('LAT: ${location.currentPosition?.latitude ?? ""}'),
                  Text('LNG: ${location.currentPosition?.longitude ?? ""}'),
                  Text('ADDRESS: ${location.currentAddress ?? ""}'),
                  //const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Add functionality to save bin here
                        String binName = _binNameController.text;
                        double lat = location.currentPosition!.latitude;
                        double lng = location.currentPosition!.longitude;
                        print('Bin Name: $binName');
                        print('LatLng: ($lat, $lng)');

                        Map <String, String> bins = {
                          'binName': _binNameController.text,
                          'lat': location.currentPosition!.latitude.toString(),
                          'lng': location.currentPosition!.longitude.toString()
                        };

                        String index = (nodes.length + 1).toString();

                        dbRef.child("0$index").set(bins);

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MapPage()));
                      }
                    },
                    child: Text('Add Bin'),
                  ),
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _binNameController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}