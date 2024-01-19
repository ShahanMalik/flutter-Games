import 'dart:math';

import 'package:flutter/material.dart';

class LudoBoard extends StatefulWidget {
  const LudoBoard({super.key});

  @override
  State<LudoBoard> createState() => _LudoBoardState();
}

class _LudoBoardState extends State<LudoBoard> {
  double xPosition = 41;
  double yPosition = 64;
  double x2Position = 92;
  double y2Position = 63;
  double x3Position = 41;
  double y3Position = 115;
  double x4Position = 83;
  double y4Position = 120;
  double x1Po = 91.5;
  double y1Po = 250.0;
  double x2Po = 38.0;
  double y2Po = 239.5;
  double x3Po = 77;
  double y3Po = 294.0;
  double x4Po = 51;
  double y4Po = 303;
  int value1 = 0;
  int value2 = 0;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.04;
    final width = MediaQuery.of(context).size.width * 0.06;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ludo'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value1.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 53,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                value2.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 53,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
                // alignment: Alignment.center,
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage('assets/luddoPic.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: [
                    GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          xPosition += details.delta.dx;
                          yPosition += details.delta.dy;
                        });
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: Color.fromARGB(255, 166, 208, 243),
                        ),
                        height: height,
                        width: width,
                        child: Text("🔵"),
                        margin: EdgeInsets.only(
                          left: xPosition < 0 ? 0 : xPosition,
                          top: yPosition < 0 ? 0 : yPosition,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          x2Position += details.delta.dx;
                          y2Position += details.delta.dy;
                        });
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: Color.fromARGB(255, 166, 208, 243),
                        ),
                        height: height,
                        width: width,
                        child: Text("🔵"),
                        margin: EdgeInsets.only(
                          left: x2Position < 0 ? 0 : x2Position,
                          top: y2Position < 0 ? 0 : y2Position,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          x3Position += details.delta.dx;
                          y3Position += details.delta.dy;
                        });
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: Color.fromARGB(255, 166, 208, 243),
                        ),
                        height: height,
                        width: width,
                        child: Text("🔵"),
                        margin: EdgeInsets.only(
                          left: x3Position < 0 ? 0 : x3Position,
                          top: y3Position < 0 ? 0 : y3Position,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          x4Position += details.delta.dx;
                          y4Position += details.delta.dy;
                        });
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: Color.fromARGB(255, 166, 208, 243),
                        ),
                        height: height,
                        width: width,
                        child: Text("🔵"),
                        margin: EdgeInsets.only(
                          left: x4Position < 0 ? 0 : x4Position,
                          top: y4Position < 0 ? 0 : y4Position,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          x1Po += details.delta.dx;
                          y1Po += details.delta.dy;
                        });
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: Color.fromARGB(255, 242, 158, 165),
                        ),
                        height: height,
                        width: width,
                        child: Text('🔴'),
                        margin: EdgeInsets.only(
                          left: x1Po < 0 ? 0 : x1Po,
                          top: y1Po < 0 ? 0 : y1Po,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          x2Po += details.delta.dx;
                          y2Po += details.delta.dy;
                        });
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: Color.fromARGB(255, 242, 158, 165),
                        ),
                        height: height,
                        width: width,
                        child: Text('🔴'),
                        margin: EdgeInsets.only(
                          left: x2Po < 0 ? 0 : x2Po,
                          top: y2Po < 0 ? 0 : y2Po,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          x3Po += details.delta.dx;
                          y3Po += details.delta.dy;
                        });
                      },
                      child: Container(
                        height: height,
                        width: width,
                        alignment: Alignment.topCenter,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: Color.fromARGB(255, 242, 158, 165),
                        ),
                        child: Text('🔴'),
                        margin: EdgeInsets.only(
                          left: x3Po < 0 ? 0 : x3Po,
                          top: y3Po < 0 ? 0 : y3Po,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onPanUpdate: (details) {
                        setState(() {
                          x4Po += details.delta.dx;
                          y4Po += details.delta.dy;
                        });
                      },
                      child: Container(
                        alignment: Alignment.topCenter,
                        decoration: ShapeDecoration(
                          shape: CircleBorder(),
                          color: Color.fromARGB(255, 242, 158, 165),
                        ),
                        height: height,
                        width: width,
                        child: Text('🔴'),
                        margin: EdgeInsets.only(
                          left: x4Po < 0 ? 0 : x4Po,
                          top: y4Po < 0 ? 0 : y4Po,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
            height: height * 0.6,
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  value1 = Random().nextInt(6) + 1;
                  value2 = Random().nextInt(6) + 1;
                });
              },
              child: Text('Roll Dice'))
        ],
      ),
    );
  }
}
