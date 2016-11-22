part of main;

/**
 * The representation of one lane of the street within the game's scene. The
 * lane is one horizontal strip of the grid and is populated with vehicles.
 */
class Lane {
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

  /**
   * The list of Vehicles currently traveling through this Lane.
   * This list is populated by the Scene class.
   */
  // TODO: Vehicles list
  List<Car> _vehicles;

  /** Lane's constructor */
  Lane(int width, int height, int offset, int laneNumber) {
    _width = width;
    _height = height;
    _offset = offset;
    _travelFlow = getTravelFlow(laneNumber);
    _random = new Random();
  }

  /** Given an integer (lane number), returns the direction of travel within
   * this Lane.
   * @param laneNumber: An integer (within range of Scene's NUM_LANES attribute).
   * @return A value of the Direction enum.
   */
  Direction getTravelFlow(int laneNumber) {
    if ((laneNumber + 1) % 2 == 0) {
      return Direction.RIGHT;
    } else {
      return Direction.LEFT;
    }
  }

  /**
   * Upon instantiation, populates the Lane with Vehicles.
   * @param cellWidth: The width (in pixels) of one cell; vehicle widths are
   *        adjusted relative to this.
   * @param cellHeight: The height (in pixels) of one cell on the grid.
   */
  void initVehicles(int cellWidth, int cellHeight) {
    _vehicles = []; // Create a variable-length list

    // Cars spawn in the odd-numbered (left-traveling) lanes
    if (_travelFlow == Direction.LEFT) {
      for (int i = 0; i < 3; i++) {
        Color randColor = Color.values[_random.nextInt(Color.values.length)];
        int offset = (_width ~/ cellWidth) ~/ (3 * (i + 1));
        _vehicles.add(new Car(randColor, cellWidth, cellHeight, offset));
      }
    }
  }

  /**
   * Updates the given context by drawing the active elements.
   * @param context: The 2D context used to render images on the HTML canvas.
   */
  void draw(CanvasRenderingContext2D context) {
    // Iterate through the Cars in this Lane and draw each of them
    for (Car vehicle in _vehicles) {
      vehicle.draw(context, _offset);
    }
  }
}