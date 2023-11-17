import 'package:animation/Screen/animation3.dart';
import 'package:animation/Screen/chess.dart';
import 'package:animation/Screen/hero_screen.dart';
import 'package:animation/Screen/hero_screen2.dart';
import 'package:animation/Screen/tic_tac_toe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation'),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SvgPicture.string(
            //   'assets/googleIcon.svg',
            //   width: 15,
            //   height: 15,
            // ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HeroScreen(),
                  ),
                );
              },
              child: Text('Hero Animation'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TicTacToeGame(),
                  ),
                );
              },
              child: Text('Tic tac toe'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CardSwipeDemo(),
                  ),
                );
              },
              child: Text('Card Swipe'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PhysicsCardDragDemo(),
                  ),
                );
              },
              child: Text('Physics Card'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChessGame(),
                  ),
                );
              },
              child: Text('chess game'),
            ),
          ],
        ),
      ),
    );
  }
}
