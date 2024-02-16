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

int maxTemp = 25;

class BinTile extends StatelessWidget {
  Bin bin;
  //final Function(Bin) onEditPressed;
  BinTile({
    super.key,
    required this.bin,
  });

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
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.access_time_filled_sharp,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const TimerPage(), // Replace YourNextPage() with the page you want to navigate to
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          // Rest of BinTile content...

          //bin pic
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(bin.img, height: 100, fit: BoxFit.cover),
            ),
          ),

          //name
          Padding(
            padding: const EdgeInsets.all(5.0),
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
                Column(
                  children: [
                    const Text(
                      'Fullness',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
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
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'Temperature',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      LinearPercentIndicator(
                        animation: true,
                        animationDuration: 1000,
                        lineHeight: 20,
                        percent: double.parse(bin.temp) / maxTemp,
                        progressColor:
                            getColor(double.parse(bin.temp) / maxTemp),
                        backgroundColor:
                            getColor(double.parse(bin.temp) / maxTemp)
                                .withOpacity(0.2),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                //TIMER GOES HERE
                //TimerPage(),
              ],
            ),
          ),

          // //Spacer
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
