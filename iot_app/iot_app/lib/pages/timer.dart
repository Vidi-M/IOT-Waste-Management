import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:iot_app/pages/models/bin.dart';
import 'models/coundown.dart';
import 'models/timedifference.dart';

Bin bin = Bin(
    img: 'lib/images/bin.png',
    name: 'Bin',
    fullness: '25',
    temp: '20',
    humidity: '65',
    maplogo: 'lib/images/map.png');

Color getColor(double value) {
  if (value <= 0.5) {
    return Colors.green;
  } else if (value <= 0.75) {
    return Colors.amber;
  } else {
    return Colors.red;
  }
}

class AddBinPage extends StatefulWidget {
  const AddBinPage({Key? key}) : super(key: key);

  @override
  _AddBinPageState createState() => _AddBinPageState();
}

class _AddBinPageState extends State<AddBinPage> {
  ///TIMER
  late CountdownTimer _countdownTimer;

  @override
  void initState() {
    super.initState();
    _countdownTimer = CountdownTimer(
      seconds: 360, // 6 minutes
      onTick: (seconds) {
        setState(() {});
      },
      onFinished: () {
        // Optionally, you can handle what to do when the countdown finishes.
        // For example, you can reset the timer.
        _countdownTimer.start();
      },
    );
    _countdownTimer.start();
  }

  @override
  void dispose() {
    _countdownTimer.stop();
    super.dispose();
  }

  ///TIMER

  @override
  Widget build(BuildContext context) {
    //TIMER
    int remainingSeconds = TimerDifferenceHandler.instance.remainingSeconds;
    int totalSeconds = 360; // 6 minutes
    double progress = remainingSeconds / (-totalSeconds);

    // if (double.parse(bin.temp) > 25) || (double.parse(bin.humidity) > 80){
    //   remainingSeconds - 10;
    // };

    //TIMER

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Bin Name'),
            ),
            const SizedBox(height: 16),
            // Add more input fields for other bin details
            const TextField(
              decoration: InputDecoration(labelText: 'Bin Location'),
            ),
            const SizedBox(height: 16),
            // LinearPercentIndicator(
            //   lineHeight: 20,
            //   percent: progress,
            //   progressColor: Colors.blue,
            //   backgroundColor: Colors.blue.shade200,
            // ),

            //TIMER
            CircularPercentIndicator(
              // animation: false,
              // animationDuration: 1000,
              radius: 40,
              lineWidth: 8,
              percent: progress,
              progressColor: getColor(progress),
              backgroundColor: getColor(progress).withOpacity(0.2),
            ),
            //TIMER

            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
