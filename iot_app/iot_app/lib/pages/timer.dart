import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iot_app/pages/components/notif.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'models/coundown.dart';
import 'models/timedifference.dart';
import 'package:iot_app/pages/models/bin.dart';
import 'package:iot_app/pages/home_page.dart';

// Bin bin = Bin(
//   img: 'lib/images/bin.png',
//   name: 'Bin',
//   fullness: '25',
//   temp: '30',
// );

Color getColor(double value) {
  if (value <= 0.5) {
    return Colors.green;
  } else if (value <= 0.75) {
    return Colors.amber;
  } else {
    return Colors.red;
  }
}

class Timer extends StatefulWidget {
  final String temp;
  const Timer(this.temp, {Key? key}) : super(key: key);

  @override
  _TimerState createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  ///TIMER
  late CountdownTimer _countdownTimer;
  int countdownSeconds = 180; // Initial remaining time (3 minutes)
  bool isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _countdownTimer = CountdownTimer(
      seconds: countdownSeconds,
      temp: widget.temp,
      onTick: (seconds) {
        print("temp: ${widget.temp}");
        if (double.parse(widget.temp) > 25) {
          countdownSeconds -=
              5; // Increase remainingSeconds by 2 if temperature is above 25
        } else {
          countdownSeconds--;
        }
        print("countdownSeconds: $countdownSeconds");

        setState(() {
          //countdownSeconds;
        });
      },
      onFinished: () {},
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
    int totalSeconds = 180; // 6 minutes
    double progress;
    if(countdownSeconds >= 0.0) {
      progress = 1 - ((countdownSeconds) / (totalSeconds));
    } else {
      progress = 0.0;
    }
    // if (double.parse(bin.temp) > 25) {
    //   remainingSeconds = remainingSeconds + 2;
    //   progress = (remainingSeconds) / (totalSeconds);
    //   print("Remaining Seconds: ${remainingSeconds}");
    // } else {
    //   progress = remainingSeconds / (totalSeconds);
    // }

    // print("Remaining Seconds: $remainingSeconds");

    //TIMER
    //print("timer countdown: $countdownSeconds");

    return Center(
        child: Column(
      children: [
        LinearPercentIndicator(
          // animation: false,
          // animationDuration: 1000,
          lineHeight: 20,
          percent: progress,
          progressColor: getColor(progress),
          backgroundColor: getColor(progress).withOpacity(0.2),
        ),

        if (countdownSeconds == 0)
          const Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              'Bin needs to be picked up!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        //TIMER
      ],
    )
        //TIMER

        //TIMER
        );
  }
}
