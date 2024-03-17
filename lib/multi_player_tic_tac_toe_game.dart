import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_toe/authentication_provider.dart';
import 'package:tic_tac_toe/models/game.dart';
import 'package:tic_tac_toe/repositories.dart';

part 'multi_player_tic_tac_toe_game.g.dart';

@riverpod
class GameNotifier extends _$GameNotifier {
  @override
  Stream<Game?> build({required String gameID}) {
    final repository = ref.watch(repositoryProvider);
    return repository.fetchGameStream(gameID: gameID).map((event) {
      log('Event $event');
      return event;
    });
  }

  Future<void> editGame({required Game game}) async {
    final repository = ref.read(repositoryProvider);
    repository.editGame(game: game);
  }

  Future<void> resetBoard() async {
    Game? game = await future;
    if (game == null) return;

    final (player1, player2) = (game.player1Id, game.player2Id);

    game = game.copyWith(
      currentPlayerId: player2,
      player1Id: player2 ?? player1,
      player2Id: player2 == null ? null : player1,
      winner: null,
      board: [
        ['', '', ''],
        ['', '', ''],
        ['', '', ''],
      ],
    );

    final repository = ref.read(repositoryProvider);
    return repository.editGame(game: game);
  }
}

class MultiPlayerTicTacToeGame extends ConsumerStatefulWidget {
  const MultiPlayerTicTacToeGame({super.key, required this.gameId});

  final String gameId;

  @override
  _MultiPlayerTicTacToeGameState createState() =>
      _MultiPlayerTicTacToeGameState();
}

class _MultiPlayerTicTacToeGameState
    extends ConsumerState<MultiPlayerTicTacToeGame> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final gameAsync = ref.watch(gameNotifierProvider(gameID: widget.gameId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic-Tac-Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: widget.gameId));
                    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                      const SnackBar(content: Text('Copied game ID')),
                    );
                  },
                  child: Text('Game ID: ${widget.gameId}'),
                );
              },
            ),
            const SizedBox(height: 20),
            switch (gameAsync) {
              AsyncData(:final value?) =>
                MultiplayerTicTacToeGameContent(game: value),
              AsyncData() => Center(
                  child: Text('Game with id ${widget.gameId} not found'),
                ),
              AsyncError(:final error) => Text('Error $error'),
              _ => const Center(
                  child: CircularProgressIndicator(),
                ),
            },
          ],
        ),
      ),
    );
  }
}

class MultiplayerTicTacToeGameContent extends ConsumerStatefulWidget {
  const MultiplayerTicTacToeGameContent({
    super.key,
    required this.game,
  });

  final Game game;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultiplayerTicTacToeGameContentState();
}

class _MultiplayerTicTacToeGameContentState
    extends ConsumerState<MultiplayerTicTacToeGameContent> {
  Game get game => widget.game;

  void _makeMove(int row, int col) {
    final board = [...game.board];
    final userID = ref.read(authenticationProvider).valueOrNull?.uid;
    bool isPlayer1 = game.player1Id == userID;

    final otherPlayerID = isPlayer1 ? game.player2Id : game.player1Id;

    if (board[row][col] == '') {
      final playerSymbol = game.player1Id == game.currentPlayerId ? 'X' : 'O';

      board[row][col] = playerSymbol;
      ref.read(gameNotifierProvider(gameID: game.id).notifier).editGame(
            game: game.copyWith(
              board: board,
              currentPlayerId: otherPlayerID ?? game.player1Id,
            ),
          );
    }
  }

  String? _checkWinner() {
    final board = [...game.board];

    for (var i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] &&
          board[i][1] == board[i][2] &&
          board[i][0] != '') {
        return board[i][0];
      }
      if (board[0][i] == board[1][i] &&
          board[1][i] == board[2][i] &&
          board[0][i] != '') {
        return board[0][i];
      }
    }
    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[0][0] != '') {
      return board[0][0];
    }

    if (board[0][2] == board[1][1] &&
        board[1][1] == board[2][0] &&
        board[0][2] != '') {
      return board[0][2];
    }

    for (var row in board) {
      for (var cell in row) {
        if (cell == '') {
          return null;
        }
      }
    }

    return 'draw';
  }

  void _resetBoard() {
    ref.read(gameNotifierProvider(gameID: game.id).notifier).resetBoard();
  }

  Widget _buildTile(int row, int col) {
    final userID = ref.watch(authenticationProvider).valueOrNull?.uid;
    List<List<String>> board = [...game.board];

    return GestureDetector(
      onTap: () {
        if (_checkWinner() == null && game.currentPlayerId == userID) {
          _makeMove(row, col);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2.0),
        ),
        width: 80.0,
        height: 80.0,
        child: Center(
          child: Text(
            board[row][col],
            style: const TextStyle(fontSize: 48.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? winner = _checkWinner();
    final currentPlayer = game.player1Id == game.currentPlayerId ? 'X' : 'O';
    String status;
    if (winner == 'draw') {
      status = "It's a draw!";
    } else if (winner != null) {
      status = 'Player $winner wins!';
    } else {
      status = 'Player $currentPlayer\'s turn';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            status,
            style: const TextStyle(fontSize: 20.0),
          ),
          const SizedBox(height: 20.0),
          Column(
            children: game.board.asMap().entries.map((entry) {
              int row = entry.key;
              List<String> rowData = entry.value;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: rowData.asMap().entries.map((cell) {
                  int col = cell.key;
                  return _buildTile(row, col);
                }).toList(),
              );
            }).toList(),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (_checkWinner() != null) {
                _resetBoard();
              }
            },
            child: const Text('Restart Game'),
          ),
        ],
      ),
    );
  }
}
