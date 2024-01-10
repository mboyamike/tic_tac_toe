import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';

@freezed
class Game with _$Game {
  const factory Game(
    final String id,
    final String player1Id,
    final String? player2Id,
    final String currentPlayerId,
  ) = _Game;
}
