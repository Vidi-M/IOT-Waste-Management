import 'package:flutter/material.dart';
import 'package:iot_app/pages/models/bin.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class BinTile extends StatelessWidget {
  Bin bin;
  BinTile({super.key, required this.bin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25),
      width: 320,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          //bin pic
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(bin.img, height: 200, fit: BoxFit.cover),
            ),
          ),

          //name
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              bin.name,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //data
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Fullness',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        CircularPercentIndicator(
                          animation: true,
                          animationDuration: 1000,
                          radius: 40,
                          lineWidth: 8,
                          percent: 0.75,
                          center: Text(
                            bin.data,
                            style: const TextStyle(fontSize: 16),
                          ),
                          progressColor: Colors.green,
                          backgroundColor: Colors.green.shade200,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Smelliness',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        CircularPercentIndicator(
                          radius: 40,
                          lineWidth: 8,
                          percent: 0.50,
                          center: Text(
                            bin.data,
                            style: const TextStyle(fontSize: 16),
                          ),
                          progressColor: Colors.blue,
                          backgroundColor: Colors.blue.shade200,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),

          // //Spacer
          const SizedBox(height: 10),

          //map
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset(
                bin.maplogo,
                height: 100,
              ),
            ),
          ),

          // edit button

          // Positioned(
          //   top: 10,
          //   left: 10,
          //   child: IconButton(
          //     icon: const Icon(Icons.edit),
          //     onPressed: () {},
          //   ),
          // )
        ],
      ),
    );
  }
}
