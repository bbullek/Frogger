part of main;

/**
 * The representation of the game's current scene, including background image,
 * objects loaded into the game, etc.
 */
class Scene {
  /** The number of lanes in the scene, based on the .png image. */
  static final int NUM_LANES = 5;

  /** The number of strips of river in the scene, based on the .png image. */
  static final int NUM_RIVERS = 5;

  /** The number of lilypads drawn at the top of the game window. */
  static final int NUM_LILYPADS = 5;

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

  /** The list of all Rivers within the scene. */
  List<River> _rivers;

  /** The list of all Lilypads within the scene. */
  List<Lilypad> _lilypads;

  /** The game's background image. */
  ImageElement _backgroundImg;

  /** The collection of audio files played during the game. */
  AudioPackage _audio;

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
    _audio = new AudioPackage();

    initFrogger();
    initLanes();
    initRivers();
    initLilypads();
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

  /**
   * Creates a new Frogger and puts him at the middle of the bottom row of
   * the game window.
   */
  void initFrogger() {
    _frogger = new Frog(_cellWidth, _cellHeight, (_numCellsX ~/ 2) * _cellWidth,
        (_numCellsY - 1) * _cellHeight);
  }

  /** Creates the Scene's list of Lanes upon instantiation. */
  void initLanes() {
    // TODO Cite https://api.dartlang.org/stable/1.20.1/dart-core/List-class.html
    _lanes = []; // Create a variable-length list
    int numOffsetCells = 7; // The number of cells above the lanes (water + grass)

    // TODO Cite https://www.dartlang.org/resources/dart-tips/dart-tips-ep-8
    for (int laneNumber = 0; laneNumber < NUM_LANES; laneNumber++) {
      int laneWidth = _cellWidth * _numCellsX;
      int laneHeight = _cellHeight;
      int laneOffset = _cellHeight * laneNumber + _cellHeight *
          numOffsetCells - (35 + 5 * laneNumber);
      // Create this Lane and add Vehicles to it
      _lanes.add(new Lane(laneWidth, laneHeight, laneOffset, laneNumber));
      _lanes[laneNumber].initVehicles(_cellWidth, _cellHeight);
    }
  }

  /** Creates the Scene's list of Rivers upon instantiation. */
  void initRivers() {
    // TODO Cite https://api.dartlang.org/stable/1.20.1/dart-core/List-class.html
    _rivers = []; // Create a variable-length list
    int numOffsetCells = 1; // The number of grass cells above the Rivers

    // TODO Cite https://www.dartlang.org/resources/dart-tips/dart-tips-ep-8
    for (int riverNumber = 0; riverNumber < NUM_RIVERS; riverNumber++) {
      int riverWidth = _cellWidth * _numCellsX;
      int riverHeight = _cellHeight;
      int riverOffset = _cellHeight * riverNumber + _cellHeight *
          numOffsetCells - (10 + 4 * riverNumber) + (1 - (riverNumber % 2)) * 10;
      // Create this River and add RiverObjects to it
      _rivers.add(new River(riverWidth, riverHeight, riverOffset, riverNumber));
      _rivers[riverNumber].initRiverObjs(_cellWidth, _cellHeight);
    }
  }

  /** Creates the Scene's list of Lilypads upon instantiation. */
  void initLilypads() {
    // TODO Cite https://api.dartlang.org/stable/1.20.1/dart-core/List-class.html
    _lilypads = []; // Create a variable-length list

    // TODO Cite https://www.dartlang.org/resources/dart-tips/dart-tips-ep-8
    for (int lilypadNum = 0; lilypadNum < NUM_LILYPADS; lilypadNum++) {
      int lilypadWidth = _cellWidth;
      int lilypadHeight = _cellHeight;
      // The horizontal offset of this Lilypad from the left of the screen
      int lilypadOffset = 2 * _cellWidth * lilypadNum + _cellWidth;
      // Create this Lilypad
      _lilypads.add(new Lilypad(lilypadWidth, lilypadHeight, lilypadOffset));
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
      if (frogger.isFloating) {
        _audio.froggerPlunk.play();
        throw new GameOverException("Floated offscreen!");
      }
      _frogger.xLoc = xLocMax;
    }
    else if (xFrogCell < 0 || frogger.xLoc < 0) {
      if (frogger.isFloating) {
        _audio.froggerPlunk.play();
        throw new GameOverException("Floated offscreen!");
      }
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
   * If Frogger is currently standing on a Lilypad, updates that Lilypad's
   * status (it now has a new Frogger sitting on it
   */
  void checkLilypads() {
    // Only check for these if Frogger is in the topmost row of the scene
    if (_frogger.yLoc > 0) return;

    List froggerX = [_frogger.xLoc, _frogger.xLoc + _frogger.width];
    int padding = _cellWidth ~/ 4;

    for (Lilypad lilypad in _lilypads) {
      List lilypadX = [lilypad.offset, lilypad.offset + lilypad.width];
      if (froggerX[0] + padding >= lilypadX[0] &&
          froggerX[1] - padding <= lilypadX[1]) {
        // Frogger has reached this Lilypad
        if (lilypad.hasFrogger) {
          // Two Froggers can't be on a Lilypad at once
          _frogger.yLoc += (_cellHeight - 4);
        } else {
          _frogger.xLoc = lilypad.offset;
          _frogger.yLoc = _cellHeight ~/ 8;
          _frogger.setImage(Direction.DOWN);
          lilypad.hasFrogger = true;
          lilypad.frog = _frogger;
          initFrogger(); // The old Frogger stays behind; spawn a new one
        }
      }
    }
  }

  /**
   * Detects whether Frogger has collided with a Vehicle and throws a
   * GameOverException if applicable.
   */
  void checkLanes() {
    // The ranges between which the Frogger sprite currently sits on the screen
    List froggerX = [_frogger.xLoc + 15, _frogger.xLoc + _frogger.width - 15];
    List froggerY = [_frogger.yLoc + 15, _frogger.yLoc + _frogger.height - 15];

    // Check whether Frogger was squished by a vehicle
    for (Lane lane in _lanes) {
      for (Vehicle vehicle in lane.vehicles) {
        List vehicleX = [vehicle.offset, vehicle.offset + vehicle.width];
        List vehicleY = [lane.offset, lane.offset + vehicle.height];
        if (overlap(froggerX[0], froggerX[1], froggerY[0], froggerY[1],
            vehicleX[0], vehicleX[1], vehicleY[0], vehicleY[1])) {
          _audio.froggerSquashed.play();
          throw new GameOverException("Frogger's been squished!");
        }
      }
    }
  }

  /**
   * Detects whether Frogger is currently on a water tile. If so, Frogger
   * must be sitting on an object (a Log or Turtle), in which case he floats
   * along with it. Otherwise, a GameOverException is thrown because he has
   * drowned.
   */
  void checkRivers() {
    // The ranges between which the Frogger sprite currently sits on the screen
    int padding = (_cellHeight * 0.5).toInt();
    List froggerX = [_frogger.xLoc + 15, _frogger.xLoc + _frogger.width - 15];
    List froggerY = [_frogger.yLoc + padding + 15,
                     _frogger.yLoc + _frogger.height + padding - 15];

    // Check whether Frogger has entered a water tile and has drowned
    for (River river in _rivers) {
      List riverX = [0, river.width];
      List riverY = [river.offset, river.offset + river.height];

      // Records whether Frogger is sitting on any RiverObject in this River
      List<bool> onObjectList = [];

      for (RiverObject riverObj in river.riverObjs) {
        // Disregard and break if Frogger isn't in this River
        bool inRiver = overlap(froggerX[0], froggerX[1], froggerY[0], froggerY[1],
            riverX[0], riverX[1], riverY[0], riverY[1]);
        if (!inRiver) break;

        List riverObjX = RiverObject.getXRange(riverObj);

        bool safe = (overlap(froggerX[0], froggerX[1], froggerY[0], froggerY[1],
            riverObjX[0], riverObjX[1], 0, 10000));
        onObjectList.add(safe);
        if (safe) {
          _frogger.isFloating = true;
          _frogger.floatingObj = riverObj;
          return;
        }
      }

      // If Frogger is in this River and isn't sitting on any objects, game over
      bool unsafe = onObjectList.length > 0 && !onObjectList.contains(true);
      if (unsafe) {
        _audio.froggerPlunk.play();
        throw new GameOverException("Drowned!");
      }
    }
  }

  /**
   * Given the left/right/top/bottom coordinates of two objects (r1 and r2)
   * on a 2D coordinate system, returns true if they overlap.
   */
  // TODO Cite http://gamedev.stackexchange.com/questions/586/what-is-the-fastest-way-to-work-out-2d-bounding-box-intersection
  bool overlap (int r1Left, int r1Right, int r1Top, int r1Bottom,
                int r2Left, int r2Right, int r2Top, int r2Bottom) {
    return !(r2Left > r1Right || r2Right < r1Left || r2Top > r1Bottom ||
             r2Bottom < r1Top);
  }

  /**
   * Updates autonomously moving elements within the scene (vehicles, logs,
   * etc.)
   * @param elapsed: The elapsed time (in seconds) since the last update.
   */
  void update(final double elapsed) {
    // Validate elements within the scene
    try {
      checkLilypads();
      checkLanes();
      checkRivers();
      checkFrog();
    } on GameOverException {
      throw new GameOverException("");
    }

    // Move all Vehicles forward by some velocity times the delta time slice
    updateLanes(elapsed);

    // Move all RiverObjects (Logs/Turtles) forward by some velocity
    updateRivers(elapsed);

    // If Frogger is floating, move him forward with the current
    updateFrogger(elapsed);
  }

  /**
   * If Frogger is currently floating on a RiverObject, automatically moves
   * him forward at the velocity of the RiverObject without any input from
   * the player.
   * @param elapsed: The elapsed time (in seconds) since the last update.
   */
  void updateFrogger(final double elapsed) {
    if (_frogger.isFloating) {
      // The RiverObject on which Frogger is floating
      RiverObject floatingObj = _frogger.floatingObj;
      // Calculate the distance to move Frogger based on the speed of the object
      int delta = (elapsed * RiverObject.getSpeed(floatingObj)).toInt();
      Direction dir = RiverObject.getDirection(floatingObj);
      _frogger.move(dir, delta, false);
      // Reset these variables
      _frogger.isFloating = false;
      _frogger.floatingObj = null;
    }
  }

  /**
   * Iterates through the Vehicles in each of the Scene's Lanes and moves them
   * forward in an amount proportional to the elapsed time.
   */
  void updateLanes(final double elapsed) {
    for (Lane lane in _lanes) {
      for (Vehicle vehicle in lane.vehicles) {
        int delta = (elapsed * Vehicle.getSpeed(vehicle)).toInt();
        vehicle.move(delta);
      }
      lane.clearVehicles(); // Clear any extraneous Vehicles

      // If enough time has passed, random chance of spawning a new Vehicle
      double currentTime =  new DateTime.now().millisecondsSinceEpoch / 1000.0;
      if (currentTime - lane._lastVehicleSpawnTime > lane.minVehicleSpawnTime) {
        double rand = lane.random.nextDouble();
        if (rand <= Lane.VEHICLE_SPAWN_PROB) {
          lane.lastVehicleSpawnTime = currentTime;
          // Cars spawn at the far-right end, other vehicles spawn on the left
          if (lane.laneNumber == 2 || lane.laneNumber == 4) {
            lane.spawnVehicle(_cellWidth, _cellHeight, 0 - _cellWidth * Truck.NUM_CELLS);
          } else {
            lane.spawnVehicle(_cellWidth, _cellHeight, lane.width);
          }
        }
      }
    }
  }

  /**
   * Iterates through the RiverObjects in each of the Scene's Rivers and moves
   * them forward in an amount proportional to the elapsed time.
   */
  void updateRivers(final double elapsed) {
    for (River river in _rivers) {
      for (RiverObject riverObj in river.riverObjs) {
        int delta = (elapsed * RiverObject.getSpeed(riverObj)).toInt();
        riverObj.move(delta);
      }
      river.clearRiverObjs(); // Clear any extraneous RiverObjects

      // If enough time has passed, random chance of spawning a new RiverObject
      double currentTime =  new DateTime.now().millisecondsSinceEpoch / 1000.0;
      if (currentTime - river.lastObjSpawnTime > river.minObjSpawnTime) {
        double rand = river.random.nextDouble();
        if (rand <= River.RIVER_SPAWN_PROB) {
          river.lastObjSpawnTime = currentTime;
          // Logs spawn at the far-right end, Turtles spawn on the left
          if (river.riverNumber % 2 == 0) { // Turtles
            river.spawnRiverObj(_cellWidth, _cellHeight,
                0 - (_cellWidth * Turtle.NUM_CELLS).toInt());
          } else {
            river.spawnRiverObj(_cellWidth, _cellHeight, river.width);
          }
        }
      }
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

    // Draw each Lane
    for (Lane lane in _lanes) {
      lane.draw(context);
    }

    // Draw each River
    for (River river in _rivers) {
      river.draw(context);
    }

    // Draw each Lilypad
    for (Lilypad lilypad in _lilypads) {
      lilypad.draw(context);
    }

    // Draw Frogger
    _frogger.draw(context);
  }
}