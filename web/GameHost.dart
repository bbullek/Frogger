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

  int _lastTimestamp = 0;
  double _x = 400.0;
  double _y = 300.0;

  // Constructor for the GameHost class
  GameHost(CanvasElement canvas) {
    this._canvas = canvas;
    this._keyboard = new Keyboard();
    this._scene = new Scene(canvas);
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

    double elapsed = 0.0;
    if (_lastTimestamp != 0) {
      elapsed = (time - _lastTimestamp) / 1000.0;
    }

    _lastTimestamp = time;
    return elapsed;
  }

  /**
   * Moves Frogger in the appropriate direction by checking the game's 'state'
   * (i.e. which key(s) is/are currently being pressed).
   *
   * @param elapsed - The elapsed time (in seconds) since the last update.
   */
  void _update(final double elapsed) {
    final double velocity = 100.0; // Adjust position by 100 pixels per second

    if (_keyboard.isPressed(KeyCode.LEFT)) _x -= velocity * elapsed;
    if (_keyboard.isPressed(KeyCode.RIGHT)) _x += velocity * elapsed;
    if (_keyboard.isPressed(KeyCode.UP)) _y -= velocity * elapsed;
    if (_keyboard.isPressed(KeyCode.DOWN)) _y += velocity * elapsed;
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