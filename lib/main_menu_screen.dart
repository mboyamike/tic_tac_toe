import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/single_player_tic_tac_toe_game.dart';

import 'multi_player_tic_tac_toe_game.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  // Generate a random game ID
  String _generateRandomGameId() {
    const int min = 1000; // You can adjust the range as needed
    const int max = 9999;
    return '${Random().nextInt(max - min + 1) + min}';
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => MultiPlayerTicTacToeGame(gameId: _generateRandomGameId(),),
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
