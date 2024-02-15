import 'dart:async';
import 'timedifference.dart'; // Assuming TimerDifferenceHandler class is defined in a separate file

class CountdownTimer {
  int _countdownSeconds;
  late Timer _timer;
  final Function(int)? _onTick;
  final Function()? _onFinished;
  final TimerDifferenceHandler _timerHandler = TimerDifferenceHandler.instance;
  bool _onPausedCalled = false;

  CountdownTimer({
    required int seconds,
    Function(int)? onTick,
    Function()? onFinished,
  })  : _countdownSeconds = seconds,
        _onTick = onTick,
        _onFinished = onFinished;

  void start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _countdownSeconds--;
      if (_onTick != null) {
        _onTick!(_countdownSeconds);
      }

      if (_countdownSeconds <= 0) {
        stop();
        if (_onFinished != null) {
          _onFinished!();
        }
      }
    });
  }

  void pause() {
    if (_onPausedCalled) return; // Prevents multiple calls to pause
    _onPausedCalled = true;
    stop();
    _timerHandler.setEndingTime(_countdownSeconds);
  }

  void resume() {
    if (!_onPausedCalled) return; // If resume is called without pause, do nothing
    if (_timerHandler.remainingSeconds > 0) {
      _countdownSeconds = _timerHandler.remainingSeconds;
      start();
    } else {
      stop();
      if (_onTick != null) {
        _onTick!(_countdownSeconds);
      }
    }
    _onPausedCalled = false;
  }

  void stop() {
    _timer.cancel();
    _countdownSeconds = 0;
  }
}
