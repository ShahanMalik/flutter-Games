import 'package:flutter/material.dart';

class ChessPiece {
  final int row;
  final int col;

  ChessPiece({required this.row, required this.col});
}

class GameState {
  final List<List<String>> board;
  final List<String> capturedPieces1;
  final List<String> capturedPieces2;

  GameState({
    required this.board,
    required this.capturedPieces1,
    required this.capturedPieces2,
  });

  GameState copyWith({
    List<List<String>>? board,
    List<String>? capturedPieces1,
    List<String>? capturedPieces2,
  }) {
    return GameState(
      board: board ?? this.board.map((row) => List<String>.from(row)).toList(),
      capturedPieces1:
          List<String>.from(capturedPieces1 ?? this.capturedPieces1),
      capturedPieces2:
          List<String>.from(capturedPieces2 ?? this.capturedPieces2),
    );
  }
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

  List<GameState> previousBoards = [];
  ChessPiece? _selectedPiece;
  List<String> capturedPieces1 = [];
  List<String> capturedPieces2 = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 225, 243, 242),
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
        backgroundColor: Color.fromARGB(255, 225, 243, 242),
        title: Text(
          'Chess Game',
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontSize: 23.0,
          ),
        ),
      ),
      body: Stack(
        children: [
          ChessBoard(
            board: board,
            onPieceMoved: _movePiece,
            onSquareTap: _handleSquareTap,
            onSquareLongPress: _handleSquareLongPress,
          ),
          Positioned(
            top: 10,
            left: 10,
            child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                scrollDirection: Axis.horizontal,
                itemCount: capturedPieces2.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      capturedPieces2[index],
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                scrollDirection: Axis.horizontal,
                itemCount: capturedPieces1.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Text(
                      capturedPieces1[index],
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isLightPiece(String piece) {
    return ['♙', '♖', '♘', '♗', '♕', '♔'].contains(piece);
  }

  void _movePiece(int fromRow, int fromCol, int toRow, int toCol) {
    setState(() {
      // Save the current state before making the move
      previousBoards.add(GameState(
        board: board.map((row) => List<String>.from(row)).toList(),
        capturedPieces1: List<String>.from(capturedPieces1),
        capturedPieces2: List<String>.from(capturedPieces2),
      ));

      // Capture the opponent's piece if present
      if (board[toRow][toCol].isNotEmpty) {
        if (isLightPiece(board[toRow][toCol])) {
          capturedPieces1.add(board[toRow][toCol]);
        } else {
          capturedPieces2.add(board[toRow][toCol]);
        }
      }

      // Move the piece
      board[toRow][toCol] = board[fromRow][fromCol];
      board[fromRow][fromCol] = '';
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

  void _handleSquareLongPress(int row, int col) {}

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
        ['♖', '♘', '♗', '♚', '♔', '♗', '♘', '♖'],
      ];
      capturedPieces1 = [];
      capturedPieces2 = [];
      previousBoards.clear();
    });
  }

  void undo() {
    if (previousBoards.isNotEmpty) {
      GameState lastState = previousBoards.removeLast();
      setState(() {
        board = lastState.board;
        capturedPieces1 = lastState.capturedPieces1;
        capturedPieces2 = lastState.capturedPieces2;
      });
    } else {
      // print('No more moves to undo');
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
        color: Color.fromARGB(255, 21, 231, 199),
        child: Center(
          child: Text(
            piece,
            style: TextStyle(
              color: Colors.black,
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
              color: isWhite ? Color(0xFF769656) : Color(0xFFeeeed2),
              child: Center(
                child: Text(
                  piece,
                  style: TextStyle(
                    color: Colors.black,
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
