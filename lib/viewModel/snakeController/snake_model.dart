class SnakeGameState {
  final List<int> snakePosition;
  final int snakefood;
  final int score;
  SnakeGameState({
    required this.snakePosition,
    required this.snakefood,
    required this.score,
  });

  SnakeGameState copyWith(
      {List<int>? snakePosition, int? snakefood, int? score}) {
    return SnakeGameState(
      snakePosition: snakePosition ?? this.snakePosition,
      snakefood: snakefood ?? this.snakefood,
      score: score ?? this.score,
    );
  }
}
