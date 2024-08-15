import 'dart:async';
import 'package:animation/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';

class Fighter extends StatefulWidget {
  const Fighter({super.key});

  @override
  State<Fighter> createState() => _FighterState();
}

class _FighterState extends State<Fighter> {
  @override
  void initState() {
    super.initState();
    // Rotate the screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        snailMove(timer);
      });
    });
  }

  @override
  void dispose() {
    // Reset the screen orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

// infront from soldier
// I/flutter (22254): snailLeftMargin 560.0
// I/flutter (22254): soidierLeftMargin 432.0
// 560-432 = 128

// back from soldier
// I/flutter (22254): snailLeftMargin 400.0
// I/flutter (22254): soidierLeftMargin 432.0
// 432-400 = 32

//  start and end limit
  late double startlimit;
  late double maxRightMove;
//
  bool isSoldierWalk = true;

  bool isSnailMoveForward = true;
  bool isSnailKill = false;
  bool isSnailThread = false;
  void snailMove(Timer timer) {
    // print('snailLeftMargin $snailLeftMargin');
    if (isSnailKill) {
      Future.delayed(Duration(milliseconds: 1000), () {
        showSnailDeadDialogue();
      });
      timer.cancel();
    }
    if (soldierLeftMargin + 128 >= snailLeftMargin
        // snailLeftMargin + 32 >= soldierLeftMargin
        ) {
      isSnailThread = true;
    } else {
      isSnailThread = false;
    }
    if (snailLeftMargin <= startlimit ||
        snailLeftMargin >= startlimit &&
            snailLeftMargin < maxRightMove &&
            isSnailMoveForward) {
      snailLeftMargin += 10;
      // isSnailMoveForward = true;
    }
    if (snailLeftMargin >= maxRightMove || !isSnailMoveForward) {
      snailLeftMargin -= 10;
      isSnailMoveForward = false;
      if (snailLeftMargin <= startlimit) {
        isSnailMoveForward = true;
      }
    }
    // print('snailLeftMargin $snailLeftMargin');
    // print('soidierLeftMargin $soldierLeftMargin');
  }

  void walk() {
    if (soldierPicindex == 1 && isSoldierWalk) {
      soldierPicindex++;
    } else if (isSoldierWalk) {
      soldierPicindex--;
    } else {}
  }

  Timer? _walkTimer;

  void _startWalkingLeft() {
    _walkTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        walk();
        if (soldierLeftMargin >= 12) {
          soldierLeftMargin -= 10;
        }
      });
    });
  }

  void _startWalkingRight() {
    _walkTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {
        walk();
        if (soldierLeftMargin <= maxRightMove) {
          soldierLeftMargin += 10;
        }
      });
    });
  }

  void _stopWalking() {
    _walkTimer?.cancel();
  }

  // if (soldierLeftMargin + 128 >= snailLeftMargin
  // snailLeftMargin + 32 >= soldierLeftMargin

  int noOfTimes = 3;
  int increment = 1;
  void attack() {
    isSoldierWalk = false;
    Timer.periodic(Duration(milliseconds: 500), (timer) {
      setState(() {
        if (increment >= noOfTimes) {
          timer.cancel();
          increment = 1;
          soldierPicindex = 1;
          isSoldierWalk = true;
        } else {
          soldierPicindex += 2;
          increment++;
          if (soldierLeftMargin + 168 >= snailLeftMargin) {
            snailPicindex = 2;
            isSnailKill = true;
          }
        }
      });
    });
  }

  void jump() {
    soldierTopMargin = 0.0;
    setState(() {});
    // print('soldierTopMargin $soldierTopMargin');
    Timer.periodic(Duration(milliseconds: 400), (timer) {
      setState(() {
        soldierTopMargin = 0.1;
        // print('soldierTopMargin $soldierTopMargin');
        timer.cancel();
      });
    });
  }

  final actualColor = Color.fromARGB(255, 237, 237, 237);
  final threadColor = Color.fromARGB(255, 217, 0, 0);
  int soldierPicindex = 1;
  double soldierTopMargin = 0.1;
  double soldierLeftMargin = 2;
  double soldierRightMargin = 2;
  double soldierBottomMargin = 2;

  int snailPicindex = 1;
  double snailTopMargin = 0.22;
  double snailLeftMargin = 300;
  double snailRightMargin = 2;
  double snailBottomMargin = 2;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    maxRightMove = width * 0.7;
    startlimit = height * 0.9;
    return Scaffold(
      body: Stack(
        children: [
          RiveAnimation.asset(
            'assets/fightGame_bg.riv',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          soldierLeftMargin,
                          width * soldierTopMargin,
                          soldierRightMargin,
                          soldierBottomMargin,
                        ),
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              isSnailThread ? threadColor : actualColor,
                              BlendMode.modulate),
                          child: Image.asset(
                            'assets/p$soldierPicindex.png',
                            // 'assets/luddoPic.jpg',
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          snailLeftMargin,
                          width * snailTopMargin,
                          snailRightMargin,
                          snailBottomMargin,
                        ),
                        child: Image.asset(
                          'assets/s$snailPicindex.png',
                          // 'assets/luddoPic.jpg',
                          width: 100,
                          height: 100,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        GestureDetector(
                          onLongPressStart: (_) {
                            _startWalkingLeft();
                          },
                          onLongPressEnd: (_) {
                            _stopWalking();
                          },
                          child: Icon(
                            CupertinoIcons.arrow_left_circle_fill,
                            color: Color.fromARGB(255, 25, 253, 208),
                            size: 60,
                          ),
                        ),
                        SizedBox(width: 15),
                        GestureDetector(
                          onLongPressStart: (_) {
                            _startWalkingRight();
                          },
                          onLongPressEnd: (_) {
                            _stopWalking();
                          },
                          child: Icon(
                            CupertinoIcons.arrow_right_circle_fill,
                            color: Color.fromARGB(255, 25, 253, 208),
                            size: 60,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          soldierPicindex = 6;
                          attack();
                        },
                        icon: Icon(
                          CupertinoIcons.hammer_fill,
                          // CupertinoIcons.bolt_fill,
                          // CupertinoIcons.flame_fill,
                          color: Color.fromARGB(255, 255, 176, 57),
                          size: 60,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            jump();
                          },
                          icon: Icon(
                            CupertinoIcons.arrow_up_circle_fill,
                            color: Color.fromARGB(255, 25, 253, 208),
                            size: 60,
                          )),
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  void showSnailDeadDialogue() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('You won the game'),
        content: const Text('Play again?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Fighter()));
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
