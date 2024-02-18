import 'package:flutter/material.dart';
import 'package:iot_app/pages/timer.dart';
import 'package:iot_app/pages/models/bin.dart';
import 'package:percent_indicator/percent_indicator.dart';

Color getColor(double value) {
  if (value <= 0.5) {
    return Colors.green;
  } else if (value <= 0.75) {
    return Colors.amber;
  } else {
    return Colors.red;
  }
}

int maxTemp = 30;

class BinTile extends StatelessWidget {
  final Bin bin;

  const BinTile({
    Key? key,
    required this.bin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25),
      width: 320,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            // Bin Picture
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(bin.img, height: 100, fit: BoxFit.cover),
            ),
            const SizedBox(
                height: 10), // Spacer between Bin Picture and Bin Name
            // Bin Name
            Text(
              bin.name,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
                height: 20), // Spacer between Bin Name and Circular Indicators
            // Row for Circular Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Circular Indicator for Fullness
                Column(
                  children: [
                    const Text(
                      'Fullness',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CircularPercentIndicator(
                      animation: true,
                      animationDuration: 1000,
                      radius: 40,
                      lineWidth: 8,
                      percent: double.parse(bin.fullness) / 100,
                      center: Text(
                        bin.fullness,
                        style: const TextStyle(fontSize: 16),
                      ),
                      progressColor: getColor(double.parse(bin.fullness) / 100),
                      backgroundColor:
                          getColor(double.parse(bin.fullness) / 100)
                              .withOpacity(0.2),
                    ),
                  ],
                ),
                // Circular Indicator for Timer
                Column(
                  children: [
                    const Text(
                      'Temperature',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CircularPercentIndicator(
                      animation: true,
                      animationDuration: 1000,
                      radius: 40,
                      percent: double.parse(bin.temp) / maxTemp,
                      progressColor: getColor(double.parse(bin.temp) / maxTemp),
                      backgroundColor:
                          getColor(double.parse(bin.temp) / maxTemp)
                              .withOpacity(0.2),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
                height:
                    20), // Spacer between the Circular Indicators and Temperature
            // Linear Indicator for Temperature
            const Column(
              children: [
                Text(
                  'Time Left',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Timer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
