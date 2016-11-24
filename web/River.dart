part of main;

/**
 * A river is one horizontal strip of the grid and is populated with either
 * logs or turtles.
 */
class River {
  /**
   * The probability that a new object (Log or Turtle) will spawn in this
   * River, once the minimum spawn time has been exceeded.
   */
  static final RIVER_SPAWN_PROB = 0.25;

  /** The minimum amount of elapsed time before a new RiverObject spawns here. */
  double _minObjSpawnTime;

  /** The width (in pixels) of the River. */
  int _width;

  /** The height (in pixels) of the River. */
  int _height;

  /** The offset (in pixels) of this River from the top of the screen. */
  int _offset;

  /** The direction of travel in this Lane. */
  Direction _travelFlow;

  /** The RNG that will randomly spawn new RiverObjects in this Lane. */
  Random _random;

  /** The seconds since a new RiverObject was most recently spawned here */
  double _lastObjSpawnTime;

  /** The numeric identifier of this River (1 through 4) */
  int _riverNumber;

  /**
   * The list of RiverObjects currently traveling through this River.
   * This list is populated by the Scene class.
   */
  List<RiverObject> _riverObjs;

  /** River's constructor */
  River(int width, int height, int offset, int riverNumber) {
    _width = width;
    _height = height;
    _offset = offset;
    _riverNumber = riverNumber + 1; // Avoid zero-indexing
    _travelFlow = River.getTravelFlow(_riverNumber);
    _random = new Random();
    _lastObjSpawnTime = new DateTime.now().millisecondsSinceEpoch / 1000.0;
    _riverObjs = [];
    _minObjSpawnTime = River.getMinObjSpawnTime(_riverNumber);
  }

  /* Getters and setters */
  int get width => _width;

  int get height => _height;

  Direction get travelFlow => _travelFlow;

  List<RiverObject> get riverObjs => _riverObjs;

  int get offset => _offset;

  Random get random => _random;

  int get riverNumber => _riverNumber;

  double get minObjSpawnTime => _minObjSpawnTime;

  double get lastObjSpawnTime => _lastObjSpawnTime;

  set lastObjSpawnTime(double value) {_lastObjSpawnTime = value;}
  /* End of getters and setters */

  /** Given an integer (river number), returns the direction of travel within
   * this River.
   * @param riverNumber: An integer (within range of Scene's NUM_RIVERS
   *        attribute).
   * @return A value of the Direction enum.
   */
  static Direction getTravelFlow(int riverNumber) {
    if (riverNumber % 2 == 0) { // Turtles
      return Direction.RIGHT;
    } else { // Logs
      return Direction.LEFT;
    }
  }

  /**
   * Given an integer (river number), returns the minimum object spawn time
   * within this River. (For example, Logs spawn less quickly than Turtles.)
   */
  static double getMinObjSpawnTime(int riverNumber) {
    if (riverNumber % 2 == 0) { // Turtles
      return Turtle.MIN_RESPAWN_TIME;
    } else { // Logs
      return Log.MIN_RESPAWN_TIME;
    }
  }

  /**
   * Upon instantiation, populates the River with RiverObjects.
   * @param cellWidth: The width (in pixels) of one cell; object widths are
   *        adjusted relative to this.
   * @param cellHeight: The height (in pixels) of one cell on the grid.
   */
  void initRiverObjs(int cellWidth, int cellHeight) {
    // Turtles spawn in the even-numbered (right-traveling) rivers
    if (_riverNumber % 2 == 0) {
      // The cells in which Turtles will initially spawn
      List<int> cells = [0, 6, 12];
      for (int i = 0; i < cells.length; i++) {
        int turtleOffset = cells[i] * cellWidth;
        spawnRiverObj(cellWidth, cellHeight, turtleOffset);
      }
    }

    // Logs spawn in the odd-numbered (left-traveling) rivers
    else {
      // The cells in which Logs will initially spawn
      List<int> cells = [0, 8];
      for (int i = 0; i < cells.length; i++) {
        int logOffset = cells[i] * cellWidth;
        spawnRiverObj(cellWidth, cellHeight, logOffset);
      }
    }
  }

  /**
   * Places a RiverObject in the River at the given offset.
   * @param width: The width (in pixels) of a cell.
   * @param height: The height (in pixels) of a cell.
   * @param riverObjOffset: The offset (in pixels) from the left of the River
   *        where the RiverObject will be placed.
   */
  void spawnRiverObj(int cellWidth, int cellHeight, int riverObjOffset) {
    if (_riverNumber % 2 == 0) { // Spawn a Turtle
      _riverObjs.add(new Turtle(cellWidth, cellHeight, riverObjOffset));
    } else { // Spawn a Log
      _riverObjs.add(new Log(Log.getRandomSize(), cellWidth, cellHeight - 20,
          riverObjOffset));
    }
  }

  /**
   * Iterates through the RiverObjects in this River, removing them from the
   * active list and destroying them if they've gone off-screen (i.e. exceeded
   * the bounds of this River).
   */
  void clearRiverObjs() {
    // Create a copy so we can "modify" the List while iterating through it
    List<RiverObject> copy = [];
    for (RiverObject riverObj in _riverObjs) {
      if (!(riverObj.offset + riverObj.width < 0 || riverObj.offset > _width)) {
        copy.add(riverObj);
      }
    }
    _riverObjs = copy;
  }

  /**
   * Updates the given context by drawing the active elements.
   * @param context: The 2D context used to render images on the HTML canvas.
   */
  void draw(CanvasRenderingContext2D context) {
    // Iterate through the RiverObjects in this Lane and draw each of them
    for (RiverObject riverObj in _riverObjs) {
      riverObj.draw(context, _offset);
    }
  }
}