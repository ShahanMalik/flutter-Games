import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LudoBoard extends StatefulWidget {
  const LudoBoard({super.key});

  @override
  State<LudoBoard> createState() => _LudoBoardState();
}

class _LudoBoardState extends State<LudoBoard> {
  double bluePiece1X = 41;
  double bluePiece1Y = 64;
  double bluePiece2X = 92;
  double bluePiece2Y = 63;
  double bluePiece3X = 41;
  double bluePiece3Y = 115;
  double bluePiece4X = 83;
  double bluePiece4Y = 120;
  double redPiece1X = 91.5;
  double redPiece1Y = 250.0;
  double redPiece2X = 38.0;
  double redPiece2Y = 239.5;
  double redPiece3X = 77;
  double redPiece3Y = 294.0;
  double redPiece4X = 51;
  double redPiece4Y = 303;
  int diceValue1 = 0;
  int diceValue2 = 0;
  late final AssetImage boardImage;
  bool isFirstPlayer = true;

  @override
  void initState() {
    super.initState();
    boardImage = const AssetImage('assets/luddoPic.jpg');
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.04;
    final width = MediaQuery.of(context).size.width * 0.06;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                if (isFirstPlayer)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        diceValue1.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 53,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        diceValue2.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 53,
                        ),
                      ),
                    ],
                  )

                //dices are rolled by the first player
                else
                  Column(
                    children: [
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                      CupertinoButton(
                        child: const Text('Roll Dice'),
                        color: const Color.fromARGB(255, 25, 134, 132),
                        onPressed: () {
                          setState(() {
                            diceValue1 = Random().nextInt(6) + 1;
                            diceValue2 = Random().nextInt(6) + 1;
                            Future.delayed(const Duration(seconds: 1), () {
                              setState(() {
                                isFirstPlayer = !isFirstPlayer;
                              });
                            });
                          });
                        },
                      ),
                    ],
                  ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: boardImage,
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Stack(
                      children: [
                        _buildDraggablePiece(
                          bluePiece1X,
                          bluePiece1Y,
                          height,
                          width,
                          const Color.fromARGB(255, 41, 182, 146),
                          (dx, dy) {
                            setState(() {
                              bluePiece1X += dx;
                              bluePiece1Y += dy;
                            });
                          },
                        ),
                        _buildDraggablePiece(
                          bluePiece2X,
                          bluePiece2Y,
                          height,
                          width,
                          const Color.fromARGB(255, 41, 182, 146),
                          (dx, dy) {
                            setState(() {
                              bluePiece2X += dx;
                              bluePiece2Y += dy;
                            });
                          },
                        ),
                        _buildDraggablePiece(
                          bluePiece3X,
                          bluePiece3Y,
                          height,
                          width,
                          const Color.fromARGB(255, 41, 182, 146),
                          (dx, dy) {
                            setState(() {
                              bluePiece3X += dx;
                              bluePiece3Y += dy;
                            });
                          },
                        ),
                        _buildDraggablePiece(
                          bluePiece4X,
                          bluePiece4Y,
                          height,
                          width,
                          const Color.fromARGB(255, 41, 182, 146),
                          (dx, dy) {
                            setState(() {
                              bluePiece4X += dx;
                              bluePiece4Y += dy;
                            });
                          },
                        ),
                        _buildDraggablePiece(
                          redPiece1X,
                          redPiece1Y,
                          height,
                          width,
                          const Color.fromARGB(255, 246, 110, 101),
                          (dx, dy) {
                            setState(() {
                              redPiece1X += dx;
                              redPiece1Y += dy;
                            });
                          },
                        ),
                        _buildDraggablePiece(
                          redPiece2X,
                          redPiece2Y,
                          height,
                          width,
                          const Color.fromARGB(255, 246, 110, 101),
                          (dx, dy) {
                            setState(() {
                              redPiece2X += dx;
                              redPiece2Y += dy;
                            });
                          },
                        ),
                        _buildDraggablePiece(
                          redPiece3X,
                          redPiece3Y,
                          height,
                          width,
                          const Color.fromARGB(255, 246, 110, 101),
                          (dx, dy) {
                            setState(() {
                              redPiece3X += dx;
                              redPiece3Y += dy;
                            });
                          },
                        ),
                        _buildDraggablePiece(
                          redPiece4X,
                          redPiece4Y,
                          height,
                          width,
                          const Color.fromARGB(255, 246, 110, 101),
                          (dx, dy) {
                            setState(() {
                              redPiece4X += dx;
                              redPiece4Y += dy;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                if (!isFirstPlayer)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        diceValue1.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 53,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Text(
                        diceValue2.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 53,
                        ),
                      ),
                    ],
                  )
                else
                  CupertinoButton(
                    child: const Text('Roll Dice'),
                    color: const Color.fromARGB(255, 25, 134, 132),
                    onPressed: () {
                      setState(() {
                        diceValue1 = Random().nextInt(6) + 1;
                        diceValue2 = Random().nextInt(6) + 1;
                        Future.delayed(const Duration(seconds: 1), () {
                          setState(() {
                            isFirstPlayer = !isFirstPlayer;
                          });
                        });
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDraggablePiece(double x, double y, double height, double width,
      Color color, Function(double, double) onPanUpdate) {
    return Positioned(
      left: x,
      top: y,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            onPanUpdate(details.delta.dx, details.delta.dy);
          });
        },
        child: Container(
          height: height,
          width: width,
          child: CustomPaint(
            size: Size(width, height),
            painter: LudoTokenPainter(color: color, emoji: '♟️'),
          ),
        ),
      ),
    );
  }
}

class LudoTokenPainter extends CustomPainter {
  final Color color;
  final String emoji;

  LudoTokenPainter({required this.color, required this.emoji});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Draw the circle
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);

    // Draw the emoji
    final textPainter = TextPainter(
      text: TextSpan(
        text: emoji,
        style: TextStyle(
            fontSize: size.width / 1.4,
            color: emoji == '🔴'
                ? const Color.fromARGB(255, 51, 231, 244)
                : const Color.fromARGB(255, 229, 239, 240)),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        (size.width - textPainter.width) / 2,
        (size.height - textPainter.height) / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
