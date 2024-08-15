import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';

class RacingCarGameScreen extends StatefulWidget {
  const RacingCarGameScreen({super.key});

  @override
  _RacingCarGameScreenState createState() => _RacingCarGameScreenState();
}

class _RacingCarGameScreenState extends State<RacingCarGameScreen> {
  double carPosition = 0.5; // Initial car position (centered)
  double carWidth = 0.1; // Width of the car
  double carHeight = 0.2; // Height of the car

  List<Obstacle> obstacles = [];
  bool gameOver = false;

  late RiveAnimation asset;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          asset,
          // RiveAnimation.asset(
          //   'assets/new_file.riv',
          //   fit: BoxFit.cover,
          // ),
          Container(
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                // Update car position based on drag
                if (mounted) {
                  setState(() {
                    carPosition += details.primaryDelta! /
                        MediaQuery.of(context).size.width;
                    if (carPosition < 0.0) carPosition = 0.0;
                    if (carPosition > 1.0) carPosition = 1.0;
                  });
                }
              },
              child: Stack(
                children: [
                  Positioned(
                      bottom: 40,
                      left: carPosition * MediaQuery.of(context).size.width -
                          carWidth * MediaQuery.of(context).size.width / 2,
                      child: Text(
                        '🚔',
                        style: TextStyle(
                          fontSize: 99,
                          color: Colors.white,
                        ),
                      )
                      // Icon(
                      //   CupertinoIcons.car_detailed,
                      //   color: Color.fromARGB(255, 202, 108, 71),
                      //   size: 80,
                      // ),
                      ),
                  for (Obstacle obstacle in obstacles)
                    Positioned(
                      top: obstacle.top * MediaQuery.of(context).size.height,
                      left: obstacle.left * MediaQuery.of(context).size.width,
                      child: SvgPicture.asset(
                        'assets/bus.svg',
                        width:
                            obstacle.width * MediaQuery.of(context).size.width,
                        height: obstacle.height *
                            MediaQuery.of(context).size.height,
                      ),
                    ),
                  if (gameOver)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Game Over!',
                            style: TextStyle(
                                fontSize: 24,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                          SizedBox(height: 16),
                          OutlinedButton(
                            onPressed: () {
                              if (mounted) {
                                setState(() {
                                  // Restart the game
                                  obstacles.clear();
                                  gameOver = false;
                                });
                                startGameLoop();
                              }
                            },
                            child: Text(
                              'Restart  Game',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 231, 238, 12),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // Start the game loop
    asset = RiveAnimation.asset(
      'assets/new_file.riv',
      fit: BoxFit.cover,
    );
    super.initState();
    ;
    startGameLoop();
  }

  void startGameLoop() {
    // Update the obstacles' positions in a loop
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (!gameOver && mounted) {
        setState(() {
          // Update existing obstacles
          obstacles.forEach((obstacle) {
            obstacle.position += obstacle.speed;
            obstacle.top = obstacle.position;
          });

          // Remove obstacles that are out of the screen
          obstacles.removeWhere((obstacle) =>
              obstacle.position >
              1.0 + obstacle.height / MediaQuery.of(context).size.height);

          // Calculate the required distance between obstacles
          double minDistance = 0.5 * MediaQuery.of(context).size.height;

          // Add a new obstacle if needed
          if (obstacles.isEmpty || obstacles.last.position > minDistance) {
            obstacles.add(Obstacle());
          }

          // Check for collision
          checkCollision();

          // Restart the game loop
          startGameLoop();
        });
      }
    });
  }

  void checkCollision() {
    double carLeft = carPosition * MediaQuery.of(context).size.width -
        carWidth * MediaQuery.of(context).size.width / 2;
    double carRight = carPosition * MediaQuery.of(context).size.width +
        carWidth * MediaQuery.of(context).size.width / 2;
    double carTop = MediaQuery.of(context).size.height *
        0.8; // Adjust this value based on the car's vertical position
    double carBottom = carTop + carHeight * MediaQuery.of(context).size.height;

    for (Obstacle obstacle in obstacles) {
      double obstacleLeft = obstacle.left * MediaQuery.of(context).size.width;
      double obstacleRight =
          obstacleLeft + obstacle.width * MediaQuery.of(context).size.width;
      double obstacleTop = obstacle.top * MediaQuery.of(context).size.height;
      double obstacleBottom =
          obstacleTop + obstacle.height * MediaQuery.of(context).size.height;

      if (carLeft < obstacleRight &&
          carRight > obstacleLeft &&
          carTop < obstacleBottom &&
          carBottom > obstacleTop &&
          mounted) {
        // Collision occurred, set game over flag
        setState(() {
          gameOver = true;
        });
      }
    }
  }
}

class Obstacle {
  double position = 0.0; // Initial obstacle position
  double speed = 0.01; // Speed of obstacle movement
  double width = 0.1; // Width of the obstacle
  double height = 0.1; // Height of the obstacle
  double left = Random()
      .nextDouble(); // Initial horizontal position of the obstacle (random)
  double top =
      0.0; // Initial vertical position of the obstacle (at the top of the screen)
}
