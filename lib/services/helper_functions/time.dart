import 'dart:async';

import 'package:flutter/cupertino.dart';

class TimerService {
  Timer? _timer;
  final Stopwatch _stopwatch = Stopwatch();
  bool _isRunning = false;

  // Getter for the timer status
  bool get isRunning => _isRunning;

  // Function to start the timer
  void startTimer() {
    if (!_isRunning) {
      _isRunning = true;
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
        // Update every 10 milliseconds
      });
    }
  }

  // Function to stop the timer
  void stopTimer() {
    if (_isRunning) {
      _isRunning = false;
      _stopwatch.stop();
      _timer?.cancel();
    }
    debugPrint('Timer stopped');
    debugPrint(getReading());
  }

  // Function to reset the timer
  void resetTimer() {
    stopTimer();
    _stopwatch.reset();
  }

  // Function to get the current reading
  String getReading() {
    int milliseconds = _stopwatch.elapsedMilliseconds;
    int hours = milliseconds ~/ 3600000;
    int minutes = (milliseconds % 3600000) ~/ 60000;
    int seconds = (milliseconds % 60000) ~/ 1000;
    int remainingMilliseconds = milliseconds % 1000;

    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${remainingMilliseconds.toString().padLeft(3, '0')}';
  }
}
