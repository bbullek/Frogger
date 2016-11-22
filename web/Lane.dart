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

  /** The List of Vehicles currently traveling through this Lane. */
  // TODO: Vehicles list
  //List<Car> cars;

  /** Lane's constructor */
  Lane(int width, int height, int offset, int laneNumber) {
    _width = width;
    _height = height;
    _offset = offset;
    _travelFlow = getTravelFlow(laneNumber);
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
}