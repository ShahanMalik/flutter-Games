import 'package:flutter/material.dart';

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});
  @override
  TicTacToeGameState createState() => TicTacToeGameState();
}

class TicTacToeGameState extends State<TicTacToeGame> {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));

  bool playerXTurn = true; // true for 'X', false for 'O'
  bool gameOver = false;
  String winner = '';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 44, 107, 155),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 44, 107, 155),
        title: Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              gameOver
                  ? 'Game Over! Winner: $winner'
                  : 'Player ${playerXTurn ? '❌' : '✔'}\'s turn',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: height * 0.05),
            _buildGameBoard(width, height),
            SizedBox(height: height * 0.05),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 24, 238, 231)),
              ),
              onPressed: () {
                _resetGame();
              },
              child: Text('Restart Game'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameBoard(double width, double height) {
    return Column(
      children: List.generate(3, (row) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (col) {
            return GestureDetector(
              onTap: () {
                _onTileClicked(row, col);
              },
              child: Container(
                width: width * 0.25,
                height: height * 0.13,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    board[row][col],
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  void _onTileClicked(int row, int col) {
    if (board[row][col] == '' && !gameOver) {
      setState(() {
        board[row][col] = playerXTurn ? '❌' : '✔';
        _checkForWinner(row, col);
        playerXTurn = !playerXTurn;
      });
    }
  }

  void _checkForWinner(int row, int col) {
    String currentPlayer = board[row][col];

    // Check row
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == currentPlayer &&
          board[i][1] == currentPlayer &&
          board[i][2] == currentPlayer) {
        _endGame(currentPlayer);
        return;
      }
    }

    // Check column
    for (int i = 0; i < 3; i++) {
      if (board[0][i] == currentPlayer &&
          board[1][i] == currentPlayer &&
          board[2][i] == currentPlayer) {
        _endGame(currentPlayer);
        return;
      }
    }

    // Check diagonals
    if ((row == col || row + col == 2) &&
        ((board[0][0] == currentPlayer &&
                board[1][1] == currentPlayer &&
                board[2][2] == currentPlayer) ||
            (board[0][2] == currentPlayer &&
                board[1][1] == currentPlayer &&
                board[2][0] == currentPlayer))) {
      _endGame(currentPlayer);
      return;
    }

    // Check for a tie
    if (!board.any((row) => row.any((cell) => cell == ''))) {
      _endGame('Tie');
      return;
    }
  }

  void _endGame(String winner) {
    setState(() {
      gameOver = true;
      this.winner = winner;
    });
  }

  void _resetGame() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ''));
      playerXTurn = true;
      gameOver = false;
      winner = '';
    });
  }
}
