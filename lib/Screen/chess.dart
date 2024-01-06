import 'dart:math';

import 'package:flutter/material.dart';

class ChessPiece {
  final int row;
  final int col;

  ChessPiece({required this.row, required this.col});
}

class ChessGame extends StatefulWidget {
  @override
  _ChessGameState createState() => _ChessGameState();
}

class _ChessGameState extends State<ChessGame> {
  List<List<String>> board = [
    ['♜', '♞', '♝', '♛', '♚', '♝', '♞', '♜'],
    ['♟', '♟', '♟', '♟', '♟', '♟', '♟', '♟'],
    ['', '', '', '', '', '', '', ''],
    ['', '', '', '', '', '', '', ''],
    ['', '', '', '', '', '', '', ''],
    ['', '', '', '', '', '', '', ''],
    ['♙', '♙', '♙', '♙', '♙', '♙', '♙', '♙'],
    ['♖', '♘', '♗', '♕', '♔', '♗', '♘', '♖'],
  ];
  late List<List<List<String>>> previousBoards = [];
  ChessPiece? _selectedPiece;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _resetGame,
            icon: Icon(Icons.refresh, color: Colors.pink[200]),
          ),
          IconButton(
            onPressed: undo,
            icon: Icon(Icons.undo, color: Colors.pink[200]),
          ),
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.green[900],
        title: Text('Chess Game',
            style: TextStyle(
              color: Colors.pink[200],
              decorationStyle: TextDecorationStyle.solid,
              fontSize: 30.0,
            )),
      ),
      body: Center(
        child: ChessBoard(
          board: board,
          onPieceMoved: _movePiece,
          onSquareTap: _handleSquareTap,
          onSquareLongPress: _handleSquareLongPress,
        ),
      ),
    );
  }

  void _movePiece(int fromRow, int fromCol, int toRow, int toCol) {
    setState(() {
      previousBoards.add(board.map((row) => List<String>.from(row)).toList());
      if (board[toRow][toCol].isEmpty) {
        board[toRow][toCol] = board[fromRow][fromCol];
        board[fromRow][fromCol] = '';
      }
    });
  }

  void _handleSquareTap(int row, int col) {
    setState(() {
      if (_selectedPiece != null) {
        _movePiece(_selectedPiece!.row, _selectedPiece!.col, row, col);
        _selectedPiece = null;
      } else if (board[row][col].isNotEmpty) {
        _selectedPiece = ChessPiece(row: row, col: col);
      }
    });
  }

  void _handleSquareLongPress(int row, int col) {
    setState(() {
      if (board[row][col].isNotEmpty) {
        board[row][col] = '';
      }
    });
  }

  void _resetGame() {
    setState(() {
      board = [
        ['♜', '♞', '♝', '♛', '♚', '♝', '♞', '♜'],
        ['♟', '♟', '♟', '♟', '♟', '♟', '♟', '♟'],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['', '', '', '', '', '', '', ''],
        ['♙', '♙', '♙', '♙', '♙', '♙', '♙', '♙'],
        ['♖', '♘', '♗', '♕', '♔', '♗', '♘', '♖'],
      ];
    });
  }

  void undo() {
    if (previousBoards != [] &&
        previousBoards.isNotEmpty &&
        previousBoards.length > 0) {
      board = previousBoards.removeLast();

      setState(() {});
    } else {
      print('No more moves to undo');
    }
  }
}

class ChessSquare extends StatelessWidget {
  final bool isWhite;
  final String piece;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  ChessSquare({
    required this.isWhite,
    required this.piece,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: piece,
      feedback: Container(
        width: 40.0,
        height: 40.0,
        color: isWhite
            ? Color.fromARGB(255, 255, 255, 255)
            : Color.fromARGB(255, 255, 255, 255),
        child: Center(
          child: Text(
            piece,
            style: TextStyle(
              color: isWhite ? Colors.black : Colors.black,
              fontSize: 24.0,
            ),
          ),
        ),
      ),
      child: DragTarget(
        builder: (BuildContext context, List<String?> candidateData,
            List<dynamic> rejectedData) {
          return GestureDetector(
            onTap: onTap,
            onLongPress: onLongPress,
            child: Container(
              // color: isWhite ? Colors.brown[400] : Colors.brown[200],
              color: isWhite
                  ? Color.fromARGB(255, 184, 134, 116)
                  : Color.fromARGB(255, 227, 193, 111),
              child: Center(
                child: Text(
                  piece,
                  style: TextStyle(
                    color: isWhite ? Colors.black : Colors.black,
                    fontSize: 33.0,
                  ),
                ),
              ),
            ),
          );
        },
        onWillAccept: (data) => true,
        onAccept: (data) {
          onTap();
        },
      ),
    );
  }
}

class ChessBoard extends StatelessWidget {
  final List<List<String>> board;
  final Function(int, int, int, int) onPieceMoved;
  final Function(int, int) onSquareTap;
  final Function(int, int) onSquareLongPress;

  ChessBoard({
    required this.board,
    required this.onPieceMoved,
    required this.onSquareTap,
    required this.onSquareLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
      // color: Colors.green,
      child: GridView.builder(
        itemCount: 64,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
        ),
        itemBuilder: (context, index) {
          final isWhite = (index ~/ 8 + index % 8) % 2 == 0;
          final row = index ~/ 8;
          final col = index % 8;
          final piece = board[row][col];
          return ChessSquare(
            isWhite: isWhite,
            piece: piece,
            onTap: () {
              onSquareTap(row, col);
            },
            onLongPress: () {
              onSquareLongPress(row, col);
            },
          );
        },
      ),
    );
  }
}
