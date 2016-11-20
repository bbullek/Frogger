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
      elem._yLoc = y * _cellHeight + 10;
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

  /* Getters and setters */
  Frog get frogger => _frogger;

  set frogger(Frog value) {_frogger = value;}

  int get width => _width;

  int get height => _height;

  int get numCellsX => _numCellsX;

  int get numCellsY => _numCellsY;

  int get cellWidth => _cellWidth;

  int get cellHeight => _cellHeight;

  /**
   * Validates that Frogger hasn't gone out-of-bounds (i.e. beyond the borders
   * of the scene's grid.
   */
  void checkFrog() {
    // TODO Cite: http://www.dotnetheaven.com/article/how-to-use-getters-and-setters-method-in-dart
    int xFrogCell = _frogger.xLoc ~/ _cellWidth;
    int yFrogCell = _frogger.yLoc ~/ _cellHeight;
    int xLocMax = _cellWidth * (_numCellsX - 1);
    int yLocMax = _cellHeight * (_numCellsY - 1);

    // Validate x-location
    if (xFrogCell >= _numCellsX || frogger.xLoc > xLocMax) {
      _frogger.xLoc = xLocMax;
    }
    else if (xFrogCell < 0 || frogger.xLoc < 0) {
      _frogger.xLoc = 0;
    }

    // Validate y-location
    if (yFrogCell >= _numCellsY || frogger.yLoc > yLocMax) {
      _frogger.yLoc = yLocMax;
    }
    else if (yFrogCell < 0 || frogger.yLoc < 0) {
      _frogger.yLoc = 0;
    }
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
    context.drawImageScaled(_backgroundImg, 0, 0, _width, _height);

    // Draw Frogger
    _frogger.draw(context);
  }
}