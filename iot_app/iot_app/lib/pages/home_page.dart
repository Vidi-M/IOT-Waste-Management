import 'package:flutter/material.dart';
import 'package:iot_app/pages/models/bin.dart';

import 'components/bin_tile.dart';
import 'components/bottom_add_bar.dart';

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
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red, // Replace with appropriate colors
                  ),
                  margin: EdgeInsets.only(right: 10),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow, // Replace with appropriate colors
                  ),
                  margin: EdgeInsets.only(right: 10),
                ),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green, // Replace with appropriate colors
                  ),
                  margin: EdgeInsets.only(right: 10),
                ),
              ],
            ),
            // Spacer to push the circle button to the right
            Spacer(),
            // Circle button on the top right
            GestureDetector(
              onTap: () {
                // Handle button press
              },
              child: Container(
                width: 40,
                height: 40,
                margin: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue, // Replace with appropriate colors
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),

      // bottomNavigationBar: Container(
      //   alignment: Alignment.bottomCenter,
      //   child: ElevatedButton(
      //     onPressed: () {},
      //     child: const Text("Add Bin"),
      //   ),
      // ),

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
                        name: 'Bin1',
                        data: '100%',
                        maplogo: 'lib/images/map.png');
                    return BinTile(
                      bin: bin,
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
        padding: EdgeInsets.all(16), // Add padding to the button
        color: Colors.green[300], // Background color of the container
        child: ElevatedButton(
          // Button widget
          onPressed: () {
            // Handle button press
          },
          child: Text('Your Button Text'), // Text of the button
        ),
      ),
    );
  }
}
