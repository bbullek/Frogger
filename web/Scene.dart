part of main;

/**
 * The representation of the game's current scene, including background image,
 * objects loaded into the game, etc.
 */
class Scene {
  /** The width (in pixels) of the scene. */
  int _width;

  /** The height (in pixels) of the scene. */
  int _height;

  /** The number of horizontal cells within the scene. */
  int _numCellsX;

  /** The number of vertical cells within the scene. */
  int _numCellsY;

  /** The width (in pixels) of one cell. */
  int _cellWidth;

  /** The height (in pixels) of one cell. */
  int _cellHeight;

  /** The list that represents the objects within the scene. */
  List _elements;

  /** The game's background image. */
  ImageElement _backgroundImg;

  /** The game's Frogger character. */
  Frog _frogger;

  // Scene's constructor
  // TODO: Cite http://stackoverflow.com/questions/20716978/integer-division-in-dart
  // TODO: Cite http://blog.sethladd.com/2011/12/lists-and-arrays-in-dart.html
  Scene(CanvasElement canvas) {
    _width = canvas.width;
    _height = canvas.height;
    _numCellsX = 11;
    _numCellsY = 12;
    _cellWidth = _width ~/ _numCellsX;
    _cellHeight = _height ~/ _numCellsY;
    _backgroundImg = new ImageElement(src: "images/background.png");
    _frogger = new Frog(_cellWidth, _cellHeight, 0, 0);
    init_elems();
  }

  /**
   * Populates the _elements list once the Scene is first initialized. Places
   * the frog in the middle of the bottom row of 'cells'.
   */
  void init_elems() {
    _elements = new List(_width * _height);
    this.setElement(_numCellsX ~/ 2, _numCellsY - 1, _frogger);
  }

  /**
   * Modifies the item at the given index of the _elements array. Since Dart
   * doesn't offer support for 2D lists (TODO cite http://www.growingwiththeweb.com/2013/05/dart-my-first-steps.html),
   * some simple arithmetic will map an index from the 1D list to a coordinate
   * on our 2D grid.
   * @param x: The x-coordinate on the grid
   * @param y: The y-coordinate on the grid
   * @param elem: The element to assign to the [x, y] cell within the grid
   */
  void setElement(int x, int y, var elem) {
    _elements[x + _width * y] = elem;

    // Set Frog location within its own class
    if (elem is Frog) {
      elem._xLoc = x * _cellWidth;
      elem._yLoc = y * _cellHeight;
    }
  }

  /**
   * Returns the item at the given index of the _elements array. Since Dart
   * doesn't offer support for 2D lists (TODO cite http://www.growingwiththeweb.com/2013/05/dart-my-first-steps.html),
   * some simple arithmetic will map an index from the 1D list to a coordinate
   * on our 2D grid.
   * @param x: The x-coordinate on the grid
   * @param y: The y-coordinate on the grid
   * @return The element stored within the indicated cell
   */
  dynamic getElement(int x, int y) {
    return _elements[x + _width * y];
  }

  /**
   * Updates the given context by drawing the active elements.
   * @param context: The 2D context used to render images on the HTML canvas.
   */
  void draw(CanvasRenderingContext2D context) {
    // TODO Cite: https://api.dartlang.org/stable/1.20.1/dart-html/CanvasRenderingContext2D/drawImageScaled.html
    _backgroundImg.onLoad.listen((e) {
      context.drawImageScaled(_backgroundImg, 0, 0, _width, _height);
    });

    // Draw Frogger
    _frogger.draw(context);
  }
}