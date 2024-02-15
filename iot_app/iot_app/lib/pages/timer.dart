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
    temp: '40',
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

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  ///TIMER
  late CountdownTimer _countdownTimer;
  int _remainingSeconds = 360; // Initial remaining time (6 minutes)

  @override
  void initState() {
    super.initState();
    _countdownTimer = CountdownTimer(
      seconds: _remainingSeconds,
      onTick: (seconds) {
        if (double.parse(bin.temp) > 25) {
          print("I have reached this temp");
          // Subtract 10 seconds from remaining time
          _remainingSeconds += 10;
        }

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
    int _remainingSeconds = TimerDifferenceHandler.instance.remainingSeconds;
    int totalSeconds = 360; // 6 minutes
    double progress = _remainingSeconds / (-totalSeconds);

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
