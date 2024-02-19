import 'dart:async';
import 'timedifference.dart';
import 'package:iot_app/pages/models/bin.dart';

class CountdownTimer {
  //int _count;
  int _countdownSeconds;
  late Timer _timer;
  final Function(int)? _onTick;
  final Function()? _onFinished;
  final TimerDifferenceHandler _timerHandler = TimerDifferenceHandler.instance;
  bool _onPausedCalled = false;

  CountdownTimer({
    required int seconds,
    required String temp,
    //required int remainingSeconds,
    Function(int)? onTick,
    Function()? onFinished,
  })  : //_count = remainingSeconds, // Initialize _countdownSeconds with remainingSeconds
        _countdownSeconds = seconds,
        _onTick = onTick,
        _onFinished = onFinished;

  // start timer
  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // //_temperatureDecreased = false;
      // if (double.parse(temp) > 25) {
      //   _countdownSeconds -= 2;
      //   //_count = _countdownSeconds;
      // } else {
      //   _countdownSeconds--;
      //   // _count;
      // }

      // print("countdownSec: $_countdownSeconds");

      if (_onTick != null) {
        _onTick(_countdownSeconds);
      }

      if (_countdownSeconds <= 0) {
        stop();
        if (_onFinished != null) {
          _onFinished();
        }
      }
    });
  }

  void pause() {
    //if (_onPausedCalled) return; // Prevents multiple calls to pause
    _onPausedCalled = true;
    stop();
    _timerHandler.setEndingTime(_countdownSeconds);
  }

  void resume() {
    if (!_onPausedCalled) {
      return; // If resume is called without pause, do nothing
    }
    if (_timerHandler.remainingSeconds > 0) {
      _countdownSeconds = _timerHandler.remainingSeconds;
      start();
    } else {
      stop();
      if (_onTick != null) {
        _onTick(_countdownSeconds);
      }
    }
    _onPausedCalled = false;
  }

  void stop() {
    _timer.cancel();
    _countdownSeconds = 0;
  }
}
