import 'package:animation/res/color/colors.dart';
import 'package:animation/res/dimension/device_info.dart';
import 'package:animation/viewModel/snakeController/snake_controller.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Snake extends StatefulWidget {
  const Snake({super.key});

  @override
  State<Snake> createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Snake Game'),
          actions: [
            Consumer(builder: (context, ref, child) {
              return IconButton(
                onPressed: () {
                  ref.read(snakeProvider.notifier).resetGame();
                },
                icon: Icon(Icons.refresh),
              );
            }),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(DeviceInfo.setDeviceWidth(context) * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer(builder: (context, ref, child) {
                final snakeScore = ref.watch(snakeProvider).score;
                return Text(
                  "Score: $snakeScore",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }),
              SizedBox(
                height: 20,
              ),
              AspectRatio(
                aspectRatio: 1 / 1,
                child: Consumer(builder: (context, ref, child) {
                  final updatedSnake = ref.watch(snakeProvider);
                  final snake = ref.read(snakeProvider.notifier);
                  print(updatedSnake.snakePosition.toString());
                  return GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 20,
                      ),
                      itemCount: 300,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onVerticalDragUpdate: (details) {
                            if (updatedSnake.snakePosition.last ==
                                updatedSnake.snakefood) {
                              snake.updateSnakeFood(Random().nextInt(300));
                              snake.updateScore(5);
                            }

                            if (details.primaryDelta! > 0) {
                              // Dragging down
                              snake.updateSnakeDragdownPosition(
                                  updatedSnake.snakePosition);
                            } else if (details.primaryDelta! < 0) {
                              // Dragging up
                              snake.updateSnakeDragupPosition(
                                  updatedSnake.snakePosition);
                            }
                          },
                          onHorizontalDragUpdate: (details) {
                            if (updatedSnake.snakePosition.last ==
                                updatedSnake.snakefood) {
                              // print('Snake food');
                              snake.updateSnakeFood(Random().nextInt(300));
                              snake.updateScore(5);
                            }
                            if (details.primaryDelta! > 0) {
                              // Dragging right
                              snake.updateSnakeDragrightPosition(
                                  updatedSnake.snakePosition);
                            } else if (details.primaryDelta! < 0) {
                              // Dragging left
                              snake.updateSnakeDragleftPosition(
                                  updatedSnake.snakePosition);
                            }
                          },
                          child: Consumer(builder: (context, ref, child) {
                            final updatedSnakefood =
                                ref.watch(snakeProvider).snakefood;
                            final updatedSnake =
                                ref.watch(snakeProvider).snakePosition;
                            return Container(
                              margin: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: updatedSnake.contains(index)
                                    ? AppColors.snakeBody
                                    : updatedSnakefood == index
                                        ? AppColors.snakeFood
                                        : AppColors.snakeGameBackground,
                                // : Colors.grey[200],
                                borderRadius: BorderRadius.circular(5),
                              ),
                            );
                          }),
                        );
                      });
                }),
              ),
            ],
          ),
        ));
  }
}
