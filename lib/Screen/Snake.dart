import 'package:flutter/material.dart';
import 'dart:math';

class Snake extends StatefulWidget {
  const Snake({super.key});

  @override
  State<Snake> createState() => _SnakeState();
}

class _SnakeState extends State<Snake> {
  List<int> snakePosition = [0, 1, 2, 3, 4];
  int snakefood = 115;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color.fromARGB(255, 35, 42, 46),
        appBar: AppBar(
          title: Text('Snake Game'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 1 / 1,
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 20,
                  ),
                  itemCount: 300,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onVerticalDragUpdate: (details) {
                        if (snakePosition.last == snakefood) {
                          snakefood = Random().nextInt(300);
                        }

                        if (details.primaryDelta! > 0) {
                          // Dragging down
                          snakePosition.removeAt(0);
                          snakePosition.add(snakePosition.last + 20);
                          setState(() {});
                        } else if (details.primaryDelta! < 0) {
                          // Dragging up
                          snakePosition.removeAt(0);
                          snakePosition.add(snakePosition.last - 20);
                          setState(() {});
                        }
                      },
                      onHorizontalDragUpdate: (details) {
                        if (snakePosition.last == snakefood) {
                          snakefood = Random().nextInt(300);
                        }
                        if (details.primaryDelta! > 0) {
                          // Dragging right
                          snakePosition.removeAt(0);
                          snakePosition.add(snakePosition.last + 1);
                          setState(() {});
                        } else if (details.primaryDelta! < 0) {
                          // Dragging left
                          snakePosition.removeAt(0);
                          snakePosition.add(snakePosition.last - 1);
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: snakePosition.contains(index)
                              ? Colors.green
                              : snakefood == index
                                  ? Colors.red
                                  : Colors.grey[200],
                          // : Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
