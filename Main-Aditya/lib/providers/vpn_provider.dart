import 'dart:async';

import 'package:flutter/material.dart';

class VpnState with ChangeNotifier {
  bool _isConnected = false;
  Timer? _timer;
  bool get isConnected => _isConnected;

  bool _isTimerActive = false;
  bool get isTimerActive => _isTimerActive;

  Duration _timerDuration = const Duration();
  Duration get timerDuration => _timerDuration;

  void connect() {
    _isConnected = true;
    notifyListeners();
  }

  void disconnect() {
    _isConnected = false;
    stopTimer();
    notifyListeners();
  }

  void toggleConnection() {
    _isConnected = !_isConnected;
    if (!_isConnected) {
      stopTimer();
    }
    notifyListeners();
  }

  void startTimer() {
    if (!_isTimerActive) {
      _isTimerActive = true;
      _timerDuration = const Duration();
      _startTimerUpdate(); // Start the timer update loop
    }
  }

  void _startTimerUpdate() {
    _timer?.cancel(); // Cancel any existing timer to avoid multiple instances
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      updateTimer();
    });
  }

void updateTimer() {
  if (_isTimerActive) {
    _timerDuration += const Duration(seconds: 1);
    notifyListeners();
  }
}

void stopTimer() {
  _isTimerActive = false;
  _timer?.cancel(); // Cancel the timer when stopping
  _timerDuration = const Duration();
  notifyListeners();
}
}