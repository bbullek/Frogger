part of main;

/**
 * The representation of the game's current scene, including background image,
 * objects loaded into the game, etc.
 */
class Scene {
  /** The number of lanes in the scene, based on the .png image. */
  static final int NUM_LANES = 5;

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

  /** The list of all Lanes within the scene. */
  // TODO Cite https://api.dartlang.org/stable/1.20.1/dart-core/List-class.html
  List<Lane> _lanes;

  /** The game's background image. */
  ImageElement _backgroundImg;

  /** The game's Frogger character. */
  Frog _frogger;

  /** Scene's constructor */
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

    // Create Frogger
    _frogger = new Frog(_cellWidth, _cellHeight, (_numCellsX ~/ 2) * _cellWidth,
        (_numCellsY - 1) * _cellHeight);

    // Create Lanes
    initLanes();
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
  /* End of getters and setters */

  /** Creates the Scene's list of Lanes upon instantiation. */
  void initLanes() {
    // TODO Cite https://api.dartlang.org/stable/1.20.1/dart-core/List-class.html
    _lanes = []; // Create a variable-length list
    int numOffsetCells = 7; // The number of cells above the lanes (water + grass)

    // TODO Cite https://www.dartlang.org/resources/dart-tips/dart-tips-ep-8
    for (int laneNumber = 0; laneNumber < NUM_LANES; laneNumber++) {
      int laneWidth = _cellWidth * _numCellsX;
      int laneHeight = _cellHeight * _numCellsY;
      int laneOffset = _cellHeight * laneNumber + _cellHeight *
          numOffsetCells - (35 + 5 * laneNumber);
      // Create this Lane and add Vehicles to it
      _lanes.add(new Lane(laneWidth, laneHeight, laneOffset, laneNumber));
      _lanes[laneNumber].initVehicles(_cellWidth, _cellHeight);
    }
  }

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
   * Updates autonomously moving elements within the scene (vehicles, logs,
   * etc.)
   * @param elapsed: The elapsed time (in seconds) since the last update.
   */
  void update(final double elapsed) {
    // Move all Vehicles forward by some velocity times the delta time slice
    int delta = (elapsed * Car.SPEED).toInt();
    for (Lane lane in _lanes) {
      for (Vehicle vehicle in lane.vehicles) {
        vehicle.move(delta);
      }
      lane.checkVehicles();

      // If enough time has passed, random chance of spawning a new Vehicle
      double currentTime =  new DateTime.now().millisecondsSinceEpoch / 1000.0;
      if (currentTime - lane._lastVehicleSpawnTime > Lane.MIN_VEHICLE_SPAWN_TIME) {
        double rand = lane.random.nextDouble();
        if (rand <= Lane.VEHICLE_SPAWN_PROB) {
          lane.lastVehicleSpawnTime = currentTime;
          lane.spawnVehicle(_cellWidth, _cellHeight, lane.width);
        }
      }
    }

    // Validate elements within the scene
    checkFrog();
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

    // Draw each Lane
    for (Lane lane in _lanes) {
      lane.draw(context);
    }
  }
}