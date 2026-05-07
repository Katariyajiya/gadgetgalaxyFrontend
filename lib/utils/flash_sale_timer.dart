import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../core/theme/app_colors.dart';



class FlashSaleTimer extends StatefulWidget {
  const FlashSaleTimer({super.key});

  @override
  State<FlashSaleTimer> createState() => _FlashSaleTimerState();
}

class _FlashSaleTimerState extends State<FlashSaleTimer> {
  late Timer _timer;

  Duration _timeLeft = const Duration(hours: 8, minutes: 34, seconds: 17);

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft.inSeconds > 0) {
        setState(() {
          _timeLeft -= const Duration(seconds: 1);
        });
      } else {
        _timer.cancel(); // Stop timer when it reaches zero
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Always clean up timers to prevent memory leaks!
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Helper function to ensure numbers like '9' show as '09'
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(_timeLeft.inHours);
    final minutes = twoDigits(_timeLeft.inMinutes.remainder(60));
    final seconds = twoDigits(_timeLeft.inSeconds.remainder(60));

    return Text(
      '$hours : $minutes : $seconds',
      style: const TextStyle(
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
        fontSize: 18,
        fontFeatures: [FontFeature.tabularFigures()], // Keeps numbers from jumping around
      ),
    );
  }
}