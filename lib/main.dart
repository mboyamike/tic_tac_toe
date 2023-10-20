import 'package:flutter/material.dart';

void main() => runApp(TicTacToeApp());

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic-Tac-Toe',
      home: TicTacToeGame(),
    );
  }
}

class TicTacToeGame extends StatefulWidget {
  @override
  _TicTacToeGameState createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  late List<List<String>> _board;
  String _currentPlayer = 'X';

  @override
  void initState() {
    super.initState();
    _board = List.generate(3, (_) => List.filled(3, ''));
  }

  void _resetBoard() {
    setState(() {
      _board = List.generate(3, (_) => List.filled(3, ''));
      _currentPlayer = 'X';
    });
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] == '') {
      setState(() {
        _board[row][col] = _currentPlayer;
        _currentPlayer = (_currentPlayer == 'X') ? 'O' : 'X';
      });
    }
  }

  String? _checkWinner() {
    for (var i = 0; i < 3; i++) {
      if (_board[i][0] == _board[i][1] && _board[i][1] == _board[i][2] && _board[i][0] != '') {
        return _board[i][0];
      }
      if (_board[0][i] == _board[1][i] && _board[1][i] == _board[2][i] && _board[0][i] != '') {
        return _board[0][i];
      }
    }
    if (_board[0][0] == _board[1][1] && _board[1][1] == _board[2][2] && _board[0][0] != '') {
      return _board[0][0];
    }
    if (_board[0][2] == _board[1][1] && _board[1][1] == _board[2][0] && _board[0][2] != '') {
      return _board[0][2];
    }
    for (var row in _board) {
      for (var cell in row) {
        if (cell == '') {
          return null;
        }
      }
    }
    return 'draw';
  }

  Widget _buildTile(int row, int col) {
    return GestureDetector(
      onTap: () {
        if (_checkWinner() == null) {
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
            _board[row][col],
            style: TextStyle(fontSize: 48.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? winner = _checkWinner();
    String status;
    if (winner == 'draw') {
      status = "It's a draw!";
    } else if (winner != null) {
      status = 'Player $winner wins!';
    } else {
      status = 'Player ' + _currentPlayer + "'s turn";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Tic-Tac-Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              status,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            Column(
              children: _board.asMap().entries.map((entry) {
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
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _resetBoard();
              },
              child: Text('Restart Game'),
            ),
          ],
        ),
      ),
    );
  }
}
