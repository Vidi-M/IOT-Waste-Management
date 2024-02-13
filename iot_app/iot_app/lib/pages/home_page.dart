import 'package:flutter/material.dart';
import 'package:iot_app/pages/map_page.dart';
import 'package:iot_app/pages/models/bin.dart';
import 'package:iot_app/pages/add_bin_page.dart';

import 'components/bin_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    Bin bin = Bin(
                        img: 'lib/images/bin.png',
                        name: 'Bin${index + 1}',
                        data: '100%',
                        maplogo: 'lib/images/map.png');
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
                builder: (context) => AddBinPage(), // Replace YourNextPage() with the page you want to navigate to
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
