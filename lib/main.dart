import 'package:animation/view/Snake.dart';
import 'package:animation/view/car_game.dart';
import 'package:animation/view/chess.dart';
import 'package:animation/view/fighter.dart';
import 'package:animation/view/luddo.dart';
import 'package:animation/view/tic_tac_toe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        title: const Text(
          'Game Hub',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            _buildGameCard(
              context,
              'Soldier Game',
              Icons.sports_kabaddi,
              Fighter(),
              '👨‍✈️',
            ),
            _buildGameCard(
              context,
              'Car Game',
              Icons.directions_car,
              RacingCarGameScreen(),
              '🚗',
            ),
            _buildGameCard(
              context,
              'Luddo',
              Icons.casino,
              LudoBoard(),
              '🎲',
            ),
            _buildGameCard(
              context,
              'Snake',
              Icons.directions,
              Snake(),
              '🐍',
            ),
            _buildGameCard(
              context,
              'Tic Tac Toe',
              Icons.grid_on,
              TicTacToeGame(),
              '❌⭕️',
            ),
            _buildGameCard(
              context,
              'Chess Game',
              Icons.gamepad,
              ChessGame(),
              '♞ ♟️',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard(BuildContext context, String title, IconData icon,
      Widget gameScreen, String? Emoji) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => gameScreen,
            ),
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.02),
                Theme.of(context).colorScheme.primary.withOpacity(0.25),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Emoji != null
                    ? Text(
                        '$Emoji',
                        style: TextStyle(
                          fontSize: Emoji == '❌⭕️' ? 24 : 37,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Icon(
                        icon,
                        size: 48.0,
                        color: Theme.of(context).primaryColor,
                      ),
                const SizedBox(height: 16.0),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
