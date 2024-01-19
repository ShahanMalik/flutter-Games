import 'package:animation/viewModel/snakeController/snake_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final snakeProvider = StateNotifierProvider<SnakeNotifier, SnakeGameState>(
  (ref) {
    return SnakeNotifier(
      SnakeGameState(snakePosition: [0, 1, 2, 3], snakefood: 128, score: 0),
    );
  },
);

class SnakeNotifier extends StateNotifier<SnakeGameState> {
  SnakeNotifier(super._state);

  void updateSnakeDragupPosition(List<int> newSnakePosition) {
    newSnakePosition
      ..removeAt(0)
      ..add(newSnakePosition.last - 20);
    state = state.copyWith(snakePosition: newSnakePosition);
  }

  void updateSnakeDragdownPosition(List<int> newSnakePosition) {
    newSnakePosition
      ..removeAt(0)
      ..add(newSnakePosition.last + 20);
    state = state.copyWith(snakePosition: newSnakePosition);
  }

  void updateSnakeDragrightPosition(List<int> newSnakePosition) {
    newSnakePosition
      ..removeAt(0)
      ..add(newSnakePosition.last + 1);
    state = state.copyWith(snakePosition: newSnakePosition);
  }

  void updateSnakeDragleftPosition(List<int> newSnakePosition) {
    newSnakePosition
      ..removeAt(0)
      ..add(newSnakePosition.last - 1);
    state = state.copyWith(snakePosition: newSnakePosition);
  }

  void updateSnakeFood(int newSnakeFood) {
    state = state.copyWith(snakefood: newSnakeFood);
  }

  void updateScore(int newScore) {
    state = state.copyWith(score: newScore + state.score);
  }

  void resetGame() {
    state =
        state.copyWith(snakePosition: [0, 1, 2, 3], snakefood: 128, score: 0);
  }
}
