part of main;

/**
 * The representation of one lane of the street within the game's scene. The
 * lane is one horizontal strip of the grid and is populated with vehicles.
 */
class Lane {
  /** Once the minimum time for a new Vehicle's spawn has been satisfied, this
   * is the probability that a new Vehicle will actually spawn. (For example,
   * if MIN_VEHICLE_SPAWN_TIME is 1 second, and VEHICLE_SPAWN_PROB is 1, then
   * it is guaranteed that every single second, a new Vehicle will spawn in
   * this Lane.
   */
  static final VEHICLE_SPAWN_PROB = 0.25;

  /** The minimum amount of elapsed time before a new Vehicle spawns here. */
  double _minVehicleSpawnTime;

  /** The width (in pixels) of the Lane. */
  int _width;

  /** The height (in pixels) of the Lane. */
  int _height;

  /** The offset (in pixels) of this Lane from the top of the screen. */
  int _offset;

  /** The direction of traffic in this Lane. */
  Direction _travelFlow;

  /** The RNG that will randomly select the color of cars in this Lane. */
  Random _random;

  /** The seconds since a new Vehicle was most recently spawned in this Lane */
  double _lastVehicleSpawnTime;

  /** The numeric identifier of this Lane (1 through 5) */
  int _laneNumber;

  /**
   * The list of Vehicles currently traveling through this Lane.
   * This list is populated by the Scene class.
   */
  List<Vehicle> _vehicles;

  /** Lane's constructor */
  Lane(int width, int height, int offset, int laneNumber) {
    _width = width;
    _height = height;
    _offset = offset;
    _travelFlow = getTravelFlow(laneNumber);
    _laneNumber = laneNumber + 1; // Avoid zero-indexing
    _random = new Random();
    _lastVehicleSpawnTime = new DateTime.now().millisecondsSinceEpoch / 1000.0;
    _vehicles = [];
    _minVehicleSpawnTime = Lane.getMinSpawnTime(_laneNumber);
  }

  /* Getters and setters */
  int get width => _width;

  int get height => _height;

  Direction get travelFlow => _travelFlow;

  List<Vehicle> get vehicles => _vehicles;

  int get offset => _offset;

  Random get random => _random;

  int get laneNumber => _laneNumber;

  double get minVehicleSpawnTime => _minVehicleSpawnTime;

  double get lastVehicleSpawnTime => _lastVehicleSpawnTime;

  set lastVehicleSpawnTime(double value) {_lastVehicleSpawnTime = value;}
  /* End of getters and setters */

  /** Given an integer (lane number), returns the direction of travel within
   * this Lane.
   * @param laneNumber: An integer (within range of Scene's NUM_LANES attribute).
   * @return A value of the Direction enum.
   */
  static Direction getTravelFlow(int laneNumber) {
    if ((laneNumber + 1) % 2 == 0) {
      return Direction.RIGHT;
    } else {
      return Direction.LEFT;
    }
  }

  /**
   * Given an integer (lane number), returns the minimum vehicle spawn time
   * within this Lane. (For example, since Cars are smaller than Trucks, they
   * have a smaller respawn time.)
   */
  static getMinSpawnTime(int laneNumber) {
    if (laneNumber == 2) { // Trucks
      return Truck.MIN_RESPAWN_TIME;
    } if (laneNumber == 4) { // FireEngines
      return FireEngine.MIN_RESPAWN_TIME;
    } else { // Cars
      return Car.MIN_RESPAWN_TIME;
    }
  }

  /**
   * Upon instantiation, populates the Lane with Vehicles.
   * @param cellWidth: The width (in pixels) of one cell; vehicle widths are
   *        adjusted relative to this.
   * @param cellHeight: The height (in pixels) of one cell on the grid.
   */
  void initVehicles(int cellWidth, int cellHeight) {
    // Cars spawn in the odd-numbered (left-traveling) lanes
    if (_travelFlow == Direction.LEFT) {
      // The cells in which Cars will initially spawn
      List<int> cells = [0, 6, 12];
      // Create three Cars
      for (int i = 0; i < cells.length; i++) {
        int carOffset = cells[i] * cellWidth;
        spawnVehicle(cellWidth, cellHeight, carOffset);
      }
    }

    // Trucks spawn in the second (right-traveling) Lane
    else if (_laneNumber == 2) {
      // The cells in which Trucks will initially spawn
      List<int> cells = [0, 6];
      // Create two Trucks
      for (int i = 0; i < cells.length; i++) {
        int truckOffset = cells[i] * cellWidth;
        spawnVehicle(cellWidth, cellHeight, truckOffset);
      }
    }

    // FireEngines spawn in the fourth (right-traveling) Lane
    else if (_laneNumber == 4) {
      // The cells in which FireEngines will initially spawn
      List<int> cells = [0, 7, 14];
      // Create two FireEngines
      for (int i = 0; i < cells.length; i++) {
        int fireEngineOffset = cells[i] * cellWidth;
        spawnVehicle(cellWidth, cellHeight, fireEngineOffset);
      }
    }
  }

  /**
   * Places a Vehicle in the Lane at the given offset.
   * @param vehicleOffset: The offset (in pixels) from the left of the Lane
   *        where the Vehicle will be placed.
   * @param width: The width (in pixels) of a cell.
   * @param height: The height (in pixels) of a cell.
   */
  void spawnVehicle(int cellWidth, int cellHeight, int vehicleOffset) {
    bool isCar = _travelFlow == Direction.LEFT;
    if (isCar) {
      // Create a Car
      Color randColor = Color.values[_random.nextInt(Color.values.length)];
      _vehicles.add(new Car(randColor, cellWidth, cellHeight, vehicleOffset));
    } else if (_laneNumber == 2) {
      // Create a Truck
      _vehicles.add(new Truck(cellWidth, cellHeight, vehicleOffset));
    } else if (_laneNumber == 4) {
      // Create a FireEngine
      _vehicles.add(new FireEngine(cellWidth, cellHeight, vehicleOffset));
    }
  }

  /**
   * Iterates through the Vehicles in this Lane, removing them from the active
   * list and destroying them if they've gone off-screen (i.e. exceeded the
   * bounds of this lane).
   */
  void clearVehicles() {
    // Create a copy so we can "modify" the List while iterating through it
    List<Vehicle> copy = [];
    for (Vehicle vehicle in _vehicles) {
      if (!(vehicle.offset + 2 * vehicle.width < 0 || vehicle.offset > _width)) {
        copy.add(vehicle);
      }
    }
    _vehicles = copy;
  }

  /**
   * Updates the given context by drawing the active elements.
   * @param context: The 2D context used to render images on the HTML canvas.
   */
  void draw(CanvasRenderingContext2D context) {
    // Iterate through the Vehicles in this Lane and draw each of them
    for (Vehicle vehicle in _vehicles) {
      vehicle.draw(context, _offset);
    }
  }
}