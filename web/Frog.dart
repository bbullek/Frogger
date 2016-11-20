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

  /** The direction in which Frogger is facing */
  Direction _facing;

  /** The width (in pixels) of the Frog. */
  int _width;

  /** The height (in pixels) of the Frog. */
  int _height;

  /** The offset (in pixels) from the left of the screen to draw the Frog. */
  int _xLoc;

  /** The offset (in pixels) from the top of the screen to draw the Frog. */
  int _yLoc;

  // Frog's constructor
  Frog(int width, int height, int xLoc, int yLoc) {
    _width = width;
    _height = height;
    _xLoc = xLoc;
    _yLoc = yLoc;
    _frogImg = new ImageElement(src: "images/frog1.png");
    _facing = Direction.NORTH;
  }

  /* Getters and setters */
  Direction get facing => _facing;

  set facing(Direction value) {_facing = value;}

  int get xLoc => _xLoc;

  set xLoc(int value) { _xLoc = value; }

  int get yLoc => _yLoc;

  set yLoc(int value) { _yLoc = value; }

  /**
   * Makes the Frog hop in the given direction by the given amount.
   * @param direction: Either "left", "right", "up", or "down"
   * @param delta: The value by which to move the Frog in the given direction.
   */
  void move(String direction, int delta) {
    if (direction == "left") _xLoc -= delta;
    if (direction == "right") _xLoc += delta;
    if (direction == "up") _yLoc -= (delta - 3);
    if (direction == "down") _yLoc += (delta - 3);
  }

  /**
   * Updates the given context by rendering the Frog on the screen.
   */
  void draw(CanvasRenderingContext2D context) {
    _frogImg.onLoad.listen((e) {
      // TODO Cite: https://api.dartlang.org/stable/1.20.1/dart-html/CanvasRenderingContext2D/drawImageScaled.html
      context.drawImageScaled(_frogImg, _xLoc, _yLoc, _width, _height);
    });
    context.drawImageScaled(_frogImg, _xLoc, _yLoc, _width, _height);
  }
}