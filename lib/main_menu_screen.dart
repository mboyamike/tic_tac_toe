import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/authentication_provider.dart';
import 'package:tic_tac_toe/models/game.dart';
import 'package:tic_tac_toe/repositories.dart';
import 'package:tic_tac_toe/single_player_tic_tac_toe_game.dart';

import 'multi_player_tic_tac_toe_game.dart';

class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({super.key});

  // Generate a random game ID
  String _generateRandomGameId() {
    const int min = 1000; // You can adjust the range as needed
    const int max = 9999;
    return '${Random().nextInt(max - min + 1) + min}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Tic Tac Toe'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SinglePlayerTicTacToeGame(),
                    ),
                  );
                },
                child: const Text('New Single player Game'),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final user = await ref.read(authenticationProvider.future);
                  if (user == null) {
                    return;
                  }

                  final repository = ref.read(repositoryProvider);
                  final game = Game(
                    id: _generateRandomGameId(),
                    player1Id: user.uid,
                    player2Id: null,
                    currentPlayerId: user.uid,
                    board: [
                      ['', '', ''],
                      ['', '', ''],
                      ['', '', ''],
                    ],
                    winner: null,
                  );
                  await repository.createGame(game: game);
                  navigator.push(
                    MaterialPageRoute(
                      builder: (_) => MultiPlayerTicTacToeGame(
                        gameId: game.id,
                      ),
                    ),
                  );
                },
                child: const Text('New Multiplayer Game'),
              ),
              const SizedBox(height: 32),
              const Text('Or'),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(
                      child: TextField(
                    decoration: InputDecoration(labelText: 'Game Code'),
                  )),
                  const SizedBox(width: 16),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text('Join Multiplayer Game')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
