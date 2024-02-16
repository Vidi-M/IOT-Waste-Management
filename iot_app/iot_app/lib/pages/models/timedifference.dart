import 'package:flutter/foundation.dart';


class TimerDifferenceHandler {
  static late DateTime endingTime = DateTime.now();
  //static late DateTime? endingTime; // Nullable

  static final TimerDifferenceHandler _instance = TimerDifferenceHandler();

  static TimerDifferenceHandler get instance => _instance;

  int get remainingSeconds {
    final DateTime dateTimeNow = DateTime.now();
    //print("endingTime1: ${endingTime}");
    //print("dateTimeNow: ${dateTimeNow}");
    Duration remainingTime = dateTimeNow.difference(endingTime);
    if (endingTime == null) {
      // Handle case where endingTime is null
      return 0;
    }
    // Return in seconds
    debugPrint(
        "TimerDifferenceHandler - remaining second = ${remainingTime.inSeconds}");
    return remainingTime.inSeconds;
  }

  void setEndingTime(int durationToEnd) {
    final DateTime dateTimeNow = DateTime.now();
    // Ending time is the current time plus the remaining duration.
    endingTime = dateTimeNow.add(
      Duration(
        seconds: durationToEnd,
      ),
    );
    debugPrint(
        "TimerDifferenceHandler - setEndingTime = ${endingTime!.toLocal().toString()}");
  }
}
