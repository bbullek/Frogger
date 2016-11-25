part of main;

/**
 * Lilypads are at the top of the game's map. The only way for Frogger to
 * "win" the game is by reaching each of the Lilypads in turn, crossing the
 * road and river each time.
 */
class Lilypad {
  /** The width (in pixels) of this Lilypad. */
  int _width;

  /** The height (in pixels) of this Lilypad. */
  int _height;

  /** The offset (in pixels) from the left of the screen for this Lilypad. */
  int _offset;

  /** Whether Frogger has reached this Lilypad yet. */
  bool _hasFrogger;

  /** The Frogger standing on this Lilypad (if applicable) */
  Frog _frog;

  /** Lilypad's constructor */
  Lilypad(int width, int height, int offset) {
    _width = width;
    _height = height;
    _offset = offset;
    _hasFrogger = false;
    _frog = null;
  }

  /* Getters and setters */
  int get width => _width;

  int get height => _height;

  bool get hasFrogger => _hasFrogger;

  set hasFrogger(bool value) { _hasFrogger = value; }

  int get offset => _offset;

  Frog get frog => _frog;

  set frog(Frog value) { _frog = value; }
/* End of getters and setters */

  /**
   * Updates the given context by drawing the active elements.
   * @param context: The 2D context used to render images on the HTML canvas.
   */
  void draw(CanvasRenderingContext2D context) {
    if (hasFrogger) frog.draw(context);
  }
}