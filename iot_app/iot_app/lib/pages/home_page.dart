//import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:iot_app/pages/map_page.dart';
import 'package:iot_app/pages/models/bin.dart';
import 'package:iot_app/pages/models/bin_list.dart';
import 'package:iot_app/pages/add_bin_page.dart';
import 'package:provider/provider.dart';

import 'components/bin_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late DatabaseReference dbRef;
  late DatabaseReference nameRef;
  late String current_uID = FirebaseAuth.instance.currentUser!.uid;
  
  Set<Bin> bins = {};
  List<String> names = [];

  Future<void> fetchBins() async {
    print("fetching names");
    DataSnapshot snapshot = await nameRef.get();
    Map<dynamic, dynamic> bin = snapshot.value as Map;
    bin.forEach((key, value) {
      names.add(value['binName']);
    });

    print(names);

    dbRef.onValue.listen((event) {
      bins.clear();
      final Map<dynamic, dynamic> binData = event.snapshot.value as Map;
      //print(binData);

      List<String> fullness = [];
      List<double> temps = [];

      binData.forEach((key, value) {
        //names.add(value["binName"]);
        Map currentData = value["current"];
        double dist = currentData["distance"];
        String fill;
        if (dist < 27) {
          fill = ((27 - dist) / 27).toStringAsFixed(2);
        } else {
          fill = '0.0';
        }
        fullness.add(fill);
        double temp = currentData["temperature"];
        if (temp < 30) {
          temps.add(temp);
        } else {
          temps.add(30);
        }
      });

      print(fullness);
      print(temps);

      for (int i = 0; i < fullness.length; i++) {
        bins.add(Bin(
          img: "lib/images/bin.png",
          name: names[i],
          fullness: fullness[i],
          temp: temps[i].toString(),
        ));
      }

      print("bins: {$bins}");
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child("Raspi");
    nameRef = FirebaseDatabase.instance.ref().child("Bins").child(current_uID);
    fetchBins();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],

      //top traffic lights + map
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // Align children to the start and end of the row
          children: [
            // Circles representing traffic lights on the top left
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red, // Replace with appropriate colors
                  ),
                  margin: const EdgeInsets.only(right: 10),
                  child: const Center(
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white70,
                        //fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.amber, // Replace with appropriate colors
                  ),
                  margin: const EdgeInsets.only(right: 10),
                  child: const Center(
                    child: Text(
                      '2',
                      style: TextStyle(
                        color: Colors.white70,
                        //fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green, // Replace with appropriate colors
                  ),
                  margin: const EdgeInsets.only(right: 10),
                  child: const Center(
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Colors.white70,
                        //fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Spacer to push the circle button to the right
            const Spacer(),
            // Circle button on the top right
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MapPage(),
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
                  Icons.gps_fixed,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: bins.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Bin bin = bins.elementAt(index);

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: BinTile(
                        bin: bin,
                      ),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 25.0, left: 25, right: 25),
                child: Divider(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        // Add a container for the button
        width: double.infinity, // Make the container take up the entire width
        padding: const EdgeInsets.all(16), // Add padding to the button
        color: Colors.green[300], // Background color of the container
        child: ElevatedButton.icon(
          // Button widget
          onPressed: () {
            // Handle button press
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const AddBinPage(), // Replace YourNextPage() with the page you want to navigate to
              ),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Bin'), // Text of the button
        ),
      ),
    );
  }
}
