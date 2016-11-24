part of main;

// TODO Cite:
// http://herrrattentod.deviantart.com/art/TUTORIAL-SPRITES-Frogger-with-Unity-Playmaker-SPRI-580610502
// for image

/**
 * The Frogger character, who is represented with a .png image and has various
 * states (including animation frame and position).
 */
class Frog {
  /** Frogger's image */
  ImageElement _frogImg;

  /** The width (in pixels) of the Frog. */
  int _width;

  /** The height (in pixels) of the Frog. */
  int _height;

  /** The offset (in pixels) from the left of the screen to draw the Frog. */
  int _xLoc;

  /** The offset (in pixels) from the top of the screen to draw the Frog. */
  int _yLoc;

  /** The first coordinates that Frogger is sent to correspond to the origin. */
  int _xOrigin;
  int _yOrigin;

  /** Whether or not Frogger is currently floating on a RiverObject (Log/Turtle) */
  bool _isFloating;

  /** The RiverObject on which Frogger is floating, if applicable */
  RiverObject _floatingObj;

  /** Frog's constructor */
  Frog(int width, int height, int xLoc, int yLoc) {
    _width = width;
    _height = height;
    _xLoc = xLoc;
    _yLoc = yLoc;
    _xOrigin = xLoc;
    _yOrigin = yLoc;
    _frogImg = new ImageElement(src: "images/frogUp.png");
    _isFloating = false;
    _floatingObj = null;
  }

  /* Getters and setters */
  int get width => _width;

  int get height => _height;

  int get xLoc => _xLoc;

  set xLoc(int value) { _xLoc = value; }

  int get yLoc => _yLoc;

  set yLoc(int value) { _yLoc = value; }

  bool get isFloating => _isFloating;

  set isFloating(bool value) { _isFloating = value; }

  RiverObject get floatingObj => _floatingObj;

  set floatingObj(RiverObject value) { _floatingObj = value; }
  /* End of getters and setters */

  /**
   * Sends Frogger back to the "origin" (bottom row of the screen, in the
   * middle).
   */
  void reset() {
    _xLoc = _xOrigin;
    _yLoc = _yOrigin;
  }

  /**
   * Makes the Frog hop in the given direction by the given amount.
   * @param direction: A member of the Direction enum -- LEFT/RIGHT/UP/DOWN.
   * @param delta: The value by which to move the Frog in the given direction.
   */
  void move(Direction direction, int delta) {
    if (direction == Direction.LEFT) {
      _xLoc -= delta;
      _frogImg = new ImageElement(src: "images/frogLeft.png");
    }
    if (direction == Direction.RIGHT) {
      _xLoc += delta;
      _frogImg = new ImageElement(src: "images/frogRight.png");
    }
    if (direction == Direction.UP) {
      _yLoc -= delta;
      _frogImg = new ImageElement(src: "images/frogUp.png");
    }
    if (direction == Direction.DOWN) {
      _yLoc += delta;
      _frogImg = new ImageElement(src: "images/frogDown.png");
    }
  }

  /**
   * Updates the given context by rendering the Frog on the screen.
   * @param context: The 2D context used to render images on the HTML canvas.
   */
  void draw(CanvasRenderingContext2D context) {
    _frogImg.onLoad.listen((e) {
      // TODO Cite: https://api.dartlang.org/stable/1.20.1/dart-html/CanvasRenderingContext2D/drawImageScaled.html
      context.drawImageScaled(_frogImg, _xLoc, _yLoc, _width, _height);
    });
    context.drawImageScaled(_frogImg, _xLoc, _yLoc, _width, _height);
  }
}