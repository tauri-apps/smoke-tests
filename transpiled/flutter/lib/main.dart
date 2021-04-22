import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:flutter/models/prefs.dart';
import 'package:flutter/models/game.dart';
import 'package:flutter/models/boardcell.dart';
import 'package:flutter/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tauri 2048 Example",
      theme: ThemeData.dark(),
      home: GameScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GameWidget());
  }
}

class GameWidget extends StatefulWidget {
  @override
  _GameWidgetState createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  Game _game;
  MediaQueryData _queryData;
  final int row = 4;
  final int column = 4;
  final double cellPadding = 5.0;
  bool _isDragging = false;
  bool _isGameOver = false;
  int bestScore = 0;

  @override
  void initState() {
    super.initState();
    _readBestScore();
    _game = Game(row, column);
    newGame();
  }

  _readBestScore() async {
    dynamic res = await readScore();
    setState(() {
      bestScore = res;
    });
  }

  void newGame() {
    _game.init();
    _isGameOver = false;
    setState(() {});
  }

  void moveLeft() {
    setState(() {
      _game.moveLeft();
      checkGameOver();
    });
  }

  void moveRight() {
    setState(() {
      _game.moveRight();
      checkGameOver();
    });
  }

  void moveUp() {
    setState(() {
      _game.moveUp();
      checkGameOver();
    });
  }

  void moveDown() {
    setState(() {
      _game.moveDown();
      checkGameOver();
    });
  }

  void checkGameOver() {
    if (_game.isGameOver()) {
      _isGameOver = true;
      String title = "Finished";
      int scoreEnd = _game.score;
      if (scoreEnd > bestScore) {
        saveScore(scoreEnd);
        title = "New High Score !";
        setState(() {
          bestScore = scoreEnd;
        });
      }
      Alert(
        context: context,
        type: AlertType.info,
        title: title,
        desc: "The game is over your score is $scoreEnd.",
        buttons: [
          DialogButton(
            child: Text(
              "Close",
              style: dialogTextStyle,
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          ),
          DialogButton(
            child: Text(
              "New Game",
              style: dialogTextStyle,
            ),
            onPressed: () {
              newGame();
              Navigator.pop(context);
            },
            gradient: backgroundGradient,
          )
        ],
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<CellWidget> _cellWidget = List<CellWidget>();
    for (int r = 0; r < row; ++r) {
      for (int c = 0; c < column; ++c) {
        _cellWidget.add(CellWidget(cell: _game.get(r, c), state: this));
      }
    }
    _queryData = MediaQuery.of(context);
    List<Widget> children = List<Widget>();
    children.add(BoardGrid(this));
    children.addAll(_cellWidget);
    return Container(
      decoration: BoxDecoration(
        gradient: backgroundGradient,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(
              top: 30.0,
              bottom: 20.0,
            ),
            child: Text(
              '2048',
              style: titleTextStyle,
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: boxBackground,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child: Container(
                    width: 130.0,
                    height: 60.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Score',
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                        Text(
                          _game.score.toString(),
                          style: boxTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  child: Container(
                    width: 80.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: boxBackground,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.refresh,
                        color: textColor,
                        size: 32,
                      ),
                    ),
                  ),
                  onPressed: () {
                    newGame();
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 15.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: boxBackground,
                  ),
                  width: 130.0,
                  height: 60.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Best',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                      Text(
                        bestScore.toString(),
                        style: boxTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(
                top: 10.0,
              ),
              margin: gameMargin,
              width: boardSize().width, //_queryData.size.width,
              height: _queryData.size.width,
              child: GestureDetector(
                onVerticalDragUpdate: (detail) {
                  if (detail.delta.distance == 0 || _isDragging) {
                    return;
                  }
                  _isDragging = true;
                  if (detail.delta.direction > 0) {
                    moveDown();
                  } else {
                    moveUp();
                  }
                },
                onVerticalDragEnd: (detail) {
                  _isDragging = false;
                },
                onVerticalDragCancel: () {
                  _isDragging = false;
                },
                onHorizontalDragUpdate: (detail) {
                  if (detail.delta.distance == 0 || _isDragging) {
                    return;
                  }
                  _isDragging = true;
                  if (detail.delta.direction > 0) {
                    moveLeft();
                  } else {
                    moveRight();
                  }
                },
                onHorizontalDragDown: (detail) {
                  _isDragging = false;
                },
                onHorizontalDragCancel: () {
                  _isDragging = false;
                },
                child: Stack(
                  children: children,
                ),
              )),
        ],
      ),
    );
  }

  Size boardSize() {
    assert(_queryData != null);
    Size size = _queryData.size;
    num width = size.width - gameMargin.left - gameMargin.right;
    double ratio = size.width / size.height;
    if (ratio > 0.65) {
      width = size.height / 2;
    }
    return Size(width, width);
  }
}

class BoardGrid extends StatelessWidget {
  final _GameWidgetState _state;
  BoardGrid(this._state);

  @override
  Widget build(BuildContext context) {
    Size boardSize = _state.boardSize();
    double width =
        (boardSize.width - (_state.column + 1) * _state.cellPadding) /
            _state.column;
    List<BoxCell> _backgroundBox = List<BoxCell>();
    for (int r = 0; r < _state.row; ++r) {
      for (int c = 0; c < _state.column; ++c) {
        BoxCell box = BoxCell(
          left: c * width + _state.cellPadding * (c + 1),
          top: r * width + _state.cellPadding * (r + 1),
          size: width,
          color: cellBoxColor,
        );
        _backgroundBox.add(box);
      }
    }
    return Positioned(
        left: 0.0,
        top: 0.0,
        child: Container(
          width: _state.boardSize().width,
          height: _state.boardSize().height,
          decoration: BoxDecoration(
            color: borderColor,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Stack(
            children: _backgroundBox,
          ),
        ));
  }
}

class BoxCell extends StatelessWidget {
  final double left;
  final double top;
  final double size;
  final Color color;
  final Text text;
  BoxCell({this.left, this.top, this.size, this.color, this.text});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Center(
            child: text,
          )),
    );
  }
}

class CellWidget extends StatefulWidget {
  final BoardCell cell;
  final _GameWidgetState state;
  CellWidget({this.cell, this.state});
  _CellWidgetState createState() => _CellWidgetState();
}

class _CellWidgetState extends State<CellWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(
        milliseconds: 200,
      ),
      vsync: this,
    );
    animation = new Tween(begin: 0.0, end: 1.0).animate(controller);
  }

  dispose() {
    controller.dispose();
    super.dispose();
    widget.cell.isNew = false;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cell.isNew && !widget.cell.isEmpty()) {
      controller.reset();
      controller.forward();
      widget.cell.isNew = false;
    } else {
      controller.animateTo(1.0);
    }
    return AnimatedCellWidget(
      cell: widget.cell,
      state: widget.state,
      animation: animation,
    );
  }
}

class AnimatedCellWidget extends AnimatedWidget {
  final BoardCell cell;
  final _GameWidgetState state;
  AnimatedCellWidget(
      {Key key, this.cell, this.state, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    double animationValue = animation.value;
    Size boardSize = state.boardSize();
    double width = (boardSize.width - (state.column + 1) * state.cellPadding) /
        state.column;
    if (cell.number == 0) {
      return Container();
    } else {
      return BoxCell(
        left: (cell.column * width + state.cellPadding * (cell.column + 1)) +
            width / 2 * (1 - animationValue),
        top: cell.row * width +
            state.cellPadding * (cell.row + 1) +
            width / 2 * (1 - animationValue),
        size: width * animationValue,
        color: boxColor.containsKey(cell.number)
            ? boxColor[cell.number]
            : boxColor[boxColor.keys.last],
        text: Text(
          cell.number.toString(),
          style: TextStyle(
            fontSize: 30.0 * animationValue,
            fontWeight: FontWeight.bold,
            color: cell.number < 32 ? Colors.grey[600] : Colors.grey[50],
          ),
        ),
      );
    }
  }
}
