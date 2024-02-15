import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Timer timer;
  bool isRunning = false;
  bool isResting = false;
  int totalSeconds = 1500;
  int totalRound = 4;
  int totalGoal = 2;
  int selectedTime = 25;
  int currentRound = 3;
  int currentGoal = 1;

  final List<int> timerMinutes = [15, 20, 25, 30, 35];

  final Map timerMinutesMap = {
    15: {'minutes': 15, 'seconds': 900},
    20: {'minutes': 20, 'seconds': 1200},
    25: {'minutes': 25, 'seconds': 1500},
    30: {'minutes': 30, 'seconds': 1800},
    35: {'minutes': 35, 'seconds': 2100},
  };

  void initTimerState() {
    currentRound = 0;
    currentGoal = 0;
    timer.cancel();
    isRunning = false;
    isResting = false;
    totalSeconds = timerMinutesMap[selectedTime]['seconds'];
  }

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        if (isResting == false) {
          // resting timer set
          isResting = true;
          totalSeconds = 300;

          // total round update
          currentRound++;

          // total goal update
          if (currentRound >= totalRound) {
            currentRound = 0;
            currentGoal++;

            // goal is finished
            if (currentGoal >= totalGoal) {
              initTimerState();
            }
          }
        } else {
          // resting timer is finised
          totalSeconds = timerMinutesMap[selectedTime]['seconds'];
          isResting = false;
        }
      });
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(
        // seconds: 1,
        milliseconds: 10,
      ),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onRefreshPressed() {
    timer.cancel();
    setState(() {
      initTimerState();
    });
  }

  void onTimerPressed(int index) {
    if (isRunning) timer.cancel();
    setState(() {
      selectedTime = index;
      totalSeconds = timerMinutesMap[index]['seconds'];
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          // TITLE
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    "pomotimer".toUpperCase(),
                    style: TextStyle(
                      color: Theme.of(context).cardColor.withOpacity(0.5),
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // TIME DISPLAY
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 150,
                    decoration: BoxDecoration(
                      color: !isResting
                          ? Theme.of(context).colorScheme.background
                          : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          format(totalSeconds),
                          style: TextStyle(
                            color: !isResting
                                ? Theme.of(context).cardColor
                                : Theme.of(context).colorScheme.background,
                            fontSize: 72,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // TIMER SELECTION
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                top: 50,
                left: 10,
                right: 10,
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int index in timerMinutes)
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).cardColor,
                      ),
                      onPressed: () => onTimerPressed(index),
                      child: Text(
                        "$index",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.background,
                          fontSize: 20,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // START & REFRESH
          Flexible(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: IconButton(
                    iconSize: 75,
                    color: Theme.of(context).cardColor,
                    onPressed: isRunning ? onPausePressed : onStartPressed,
                    icon: Icon(
                      isRunning
                          ? Icons.pause_circle_outlined
                          : Icons.play_circle_outline,
                    ),
                  ),
                ),
                Center(
                  child: IconButton(
                    iconSize: 30,
                    color: Theme.of(context).cardColor,
                    onPressed: onRefreshPressed,
                    icon: const Icon(
                      Icons.refresh_outlined,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // POMODOROS
          Flexible(
            flex: 1,
            child: Row(
              children: [
                // ROUND
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'round'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$currentRound',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.7),
                              ),
                            ),
                            Text(
                              ' / $totalRound',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // GOAL
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'goal'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$currentGoal',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.7),
                              ),
                            ),
                            Text(
                              ' / $totalGoal',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
