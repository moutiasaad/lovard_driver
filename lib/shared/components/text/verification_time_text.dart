import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lovard_delivery_app/shared/language/extension.dart';
import '../../../utils/app_text_styles.dart';
import 'CText.dart';

class CountdownTimer extends StatefulWidget {
  CountdownTimer(
      {super.key, required this.secondsRemaining, required this.done});

  int secondsRemaining;
  final Function done;

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        if (widget.secondsRemaining > 0) {
          widget.secondsRemaining--;
        } else {
          widget.done();
          // Stop the timer when it reaches 0
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  bool timeEnd() {
    if (widget.secondsRemaining == 0) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cText(
            text: context.translate('login.diNotGetCode'),
            style: AppTextStyle.mediumPrimary14,
            pBottom: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
                context.translate(
                    timeEnd() ? 'login.getNewCode' : 'login.permissionCode'),
                style: timeEnd()
                    ? AppTextStyle.mediumSecondary14
                    : AppTextStyle.regularBlack1_12),
            const SizedBox(
              width: 5,
            ),
            Visibility(
              visible: !timeEnd(),
              child: Text(formatTime(widget.secondsRemaining),
                  style: AppTextStyle.mediumSecondary14),
            ),
          ],
        ),
      ],
    );
  }
}
