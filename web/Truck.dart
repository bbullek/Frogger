part of main;

/**
 * Trucks drive along the lane second from the top and should be avoided by
 * Frogger at all costs.
 */
class Truck extends Vehicle {
  /** The number of horizontal cells/units a Truck takes up within the grid. */
  static final int NUM_CELLS = 4;

  /** The fixed speed that a Truck travels. */
  static final int SPEED = 140;

  /** The respawn rate of a Truck */
  static final MIN_RESPAWN_TIME = 3.0;

  /** Truck's constructor, which calls Vehicle's constructor */
  Truck(int cellWidth, int height, int offset) :
        super(cellWidth * NUM_CELLS, height, offset, getTruckImage());

  /** Returns the appropriate image file to render within the scene.
   * @return An ImageElement with the relative path to the appropriate file.
   */
  static ImageElement getTruckImage() {
    return new ImageElement(src: "images/truck.png");
  }
}