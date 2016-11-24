part of main;

/**
 * RiverObjects are a base class for Logs and Turtles, which share much of the
 * same functionality.
 */
abstract class RiverObject {
  /** The width (in pixels) of the RiverObject. */
  int _width;

  /** The height (in pixels) of the RiverObject. */
  int _height;

  /** The pixel offset from the left of the River containing this RiverObject. */
  int _offset;

  /** The RiverObject's image */
  ImageElement _riverObjImg;

  /** RiverObject's constructor */
  RiverObject(int width, int height, int offset, ImageElement riverObjImg) {
    _width = width;
    _height = height;
    _offset = offset;
    _riverObjImg = riverObjImg;
  }

  /* Getters and setters */
  int get width => _width;

  int get height => _height;

  int get offset => _offset;
  /* End of getters and setters */

  /**
   * Returns the speed of the given RiverObject.
   * @param riverObj: An instance of a Log or Turtle
   * @return The integer value of the RiverObject's speed
   */
  static int getSpeed(RiverObject riverObj) {
    if (riverObj is Log) return Log.SPEED;
    if (riverObj is Turtle) return Turtle.SPEED;
  }

  /**
   * Returns the Direction in which the given RiverObject is traveling.
   * @param riverObj: An instance of a Log or Turtle
   * @return A value of the Direction enum
   */
  static Direction getDirection(RiverObject riverObj) {
    if (riverObj is Log) return Log.DIR;
    if (riverObj is Turtle) return Turtle.DIR;
  }

  /**
   * Gets the range of X-coordinates of the given RiverObject, adding extra
   * "cushioning" so Frogger has some legroom (otherwise, staying on a Turtle
   * would be extremely difficult)
   * @param riverObj: An instance of the RiverObject class (a Log or Turtle)
   * @return A List representing the range of x-coordinates: [xLower, xUpper]
   */
  static List getXRange(RiverObject riverObj) {
    if (riverObj is Log) {
      return [riverObj.offset - 5, riverObj.offset + riverObj.width + 5];
    } else if (riverObj is Turtle) {
      return [riverObj.offset, riverObj.offset + riverObj.width];
    } else {
      throw new StateError("Invalid RiverObject");
    }
  }

  /**
   * Makes the RiverObject move within the River by the given amount.
   * @param delta: The value by which to move the RiverObject.
   */
  void move(int delta) {
    if (this is Log) {
      _offset -= delta;
    } else {
      _offset += delta;
    }
  }

  /**
   * Updates the given context by rendering this RiverObject on the screen.
   * @param context: The 2D context used to render images on the HTML canvas.
   * @param laneOffset: The distance (in pixels) this RiverObject's
   *        corresponding River sits from the top of the screen.
   */
  void draw(CanvasRenderingContext2D context, int riverOffset) {
    _riverObjImg.onLoad.listen((e) {
      // TODO Cite: https://api.dartlang.org/stable/1.20.1/dart-html/CanvasRenderingContext2D/drawImageScaled.html
      context.drawImageScaled(_riverObjImg, _offset, riverOffset, _width, _height);
    });
    context.drawImageScaled(_riverObjImg, _offset, riverOffset, _width, _height);
  }
}