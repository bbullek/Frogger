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

  // Constructor for the GameHost class
  GameHost(CanvasElement canvas) {
    _canvas = canvas;
    _keyboard = new Keyboard();
    _scene = new Scene(canvas);
    _lastTimestamp = new DateTime.now().millisecondsSinceEpoch;
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

    // If at least 1 second has passed, reset the time-stamp
    if (elapsed > 1) {
      _lastTimestamp = time;
      return elapsed;
    }

    return 0.0; // Act as though no time has passed
  }

  /**
   * Moves Frogger in the appropriate direction by checking the game's 'state'
   * (i.e. which key(s) is/are currently being pressed).
   * @param elapsed - The elapsed time (in seconds) since the last update.
   */
  void _update(final double elapsed) {
    if (elapsed != 0) {
      int deltaX = _scene._cellWidth;
      int deltaY = _scene._cellHeight;

      if (_keyboard.isPressed(KeyCode.LEFT)) _scene._frogger.move("left", deltaX);
      if (_keyboard.isPressed(KeyCode.RIGHT)) _scene._frogger.move("right", deltaX);
      if (_keyboard.isPressed(KeyCode.UP)) _scene._frogger.move("up", deltaY);
      if (_keyboard.isPressed(KeyCode.DOWN)) _scene._frogger.move("down", deltaY);
    }
  }

  /**
   * Redraws Frogger, assuming its x and y coordinates have changed (i.e. the
   * user has used the keyboard to move him).
   */
  void _render() {
    CanvasRenderingContext2D context = _canvas.context2D;
    this._scene.draw(context);
  }
}