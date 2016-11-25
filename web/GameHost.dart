part of main;

/*
 * This class holds the state of the game (in this case just the X and Y
 * coordinates of Frogger) and continuously schedules an animation frame
 * using the draw method.
 * Each iteration of the game loop goes something like this;
 *    1. Elapsed time since last frame is calculated
 *    2. State is updated based on elapsed time and keyboard state
 *    3. Current state is rendered
 *    4. A new animation frame is requested causing this to loop again
 */
class GameHost {
  CanvasElement _canvas;
  Keyboard _keyboard;
  Scene _scene;
  int _lastTimestamp;
  int _lastVerticalHop;
  int _lastHorizontalHop;
  double _elapsedVerticalHop;
  double _elapsedHorizontalHop;
  GameState _state;
  ImageElement _gameWonImg;

  // Constructor for the GameHost class
  GameHost(CanvasElement canvas) {
    _canvas = canvas;
    _keyboard = new Keyboard();
    _scene = new Scene(canvas);
    _lastTimestamp = new DateTime.now().millisecondsSinceEpoch;
    _lastVerticalHop = new DateTime.now().millisecondsSinceEpoch;
    _lastHorizontalHop = new DateTime.now().millisecondsSinceEpoch;
    _elapsedHorizontalHop = 0.0;
    _elapsedVerticalHop = 0.0;
    _state = GameState.PLAY;
    _gameWonImg = new ImageElement(src: "images/gameWon.png");
  }

  /**
   * Triggers the main game loop by requesting a frame from the browser and
   * passing a pointer to the method that will process the new frame.
   */
  run() {
    window.requestAnimationFrame(_gameLoop);
  }

  /**
   * One iteration of the main game loop, which calls itself again once it's
   * finished. Calculates elapsed time and then renders the elements in the
   * browser by validating the game's state (including checking keyboard input).
   */
  void _gameLoop(final double _) {
    _update(_getElapsed());
    _render();
    window.requestAnimationFrame(_gameLoop);
  }

  /**
   * Calculates & returns the elapsed time since _getElapsed was last called.
   *
   * @return The elapsed time (in seconds).
   */
  double _getElapsed() {
    final int time = new DateTime.now().millisecondsSinceEpoch;
    double elapsed = (time - _lastTimestamp) / 1000.0;
    _lastTimestamp = time;

    _elapsedVerticalHop = (time - _lastVerticalHop) / 1000.0;
    _elapsedHorizontalHop = (time - _lastHorizontalHop) / 1000.0;

    return elapsed;
  }

  /**
   * Depending on the current game's state, calls the appropriate update method.
   * @param elapsed: The elapsed time (in seconds) since the last update.
   */
  void _update(final double elapsed) {
    if (_state == GameState.PLAY) updatePlayState(elapsed);
    else if (_state == GameState.WAIT) updateWaitState();
  }

  /**
   * Moves Frogger in the appropriate direction by checking which key(s) is/are
   * currently being pressed. Implements a simple checking system to prevent
   * the player from hopping around too quickly.
   * @param elapsed: The elapsed time (in seconds) since the last update.
   */
  void updatePlayState(final double elapsed) {
    int deltaX = _scene._cellWidth;
    int deltaY = _scene._cellHeight - 5;
    int time = new DateTime.now().millisecondsSinceEpoch;

    // Check if Frogger should hop sideways
    if (_elapsedHorizontalHop > 0.25) {
      if (_keyboard.isPressed(KeyCode.LEFT)) {
        _scene.frogger.move(Direction.LEFT, deltaX, true);
        _lastHorizontalHop = time;
      }
      if (_keyboard.isPressed(KeyCode.RIGHT)) {
        _scene.frogger.move(Direction.RIGHT, deltaX, true);
        _lastHorizontalHop = time;
      }
    }

    // Check if Frogger should hop forwards/backwards
    if (_elapsedVerticalHop > 0.25) {
      if (_keyboard.isPressed(KeyCode.UP)) {
        _scene.frogger.move(Direction.UP, deltaY, true);
        _lastVerticalHop = time;
      }
      if (_keyboard.isPressed(KeyCode.DOWN)) {
        _scene.frogger.move(Direction.DOWN, deltaY, true);
        _lastVerticalHop = time;
      }
    }

    // Update the rest of the scene & check for game-over
    try {
      _scene.update(elapsed);
    } on GameOverException {
      _scene.frogger.reset();
    } on GameWonException {
      _state = GameState.WAIT;
    }
  }

  /**
   * If the player presses the spacebar, resumes normal game mode. Otherwise,
   * keypresses are ignored.
   */
  void updateWaitState() {
    if (_keyboard.isPressed(KeyCode.SPACE)) {
      _state = GameState.PLAY;
      _scene.resetLilypads();
    }
  }

  /**
   * Redraws Frogger, assuming its x and y coordinates have changed (i.e. the
   * user has used the keyboard to move him).
   */
  void _render() {
    CanvasRenderingContext2D context = _canvas.context2D;
    _scene.draw(context);

    if (_state == GameState.WAIT) {
      // TODO Cite: https://api.dartlang.org/stable/1.20.1/dart-html/CanvasRenderingContext2D/drawImageScaled.html
      _gameWonImg.onLoad.listen((e) {
        context.drawImageScaled(_gameWonImg, _canvas.width ~/ 8,
            _canvas.height ~/ 2.5, _canvas.width ~/ 1.4, _canvas.height ~/ 8);
      });
      context.drawImageScaled(_gameWonImg, _canvas.width ~/ 8,
          _canvas.height ~/ 2.5, _canvas.width ~/ 1.4, _canvas.height ~/ 8);
    }
  }
}