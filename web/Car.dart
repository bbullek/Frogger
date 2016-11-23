part of main;

/**
 * Cars drive along the odd-numbered lanes within the game world and should be
 * avoided by Frogger at all costs.
 */
class Car extends Vehicle {
  /** The number of horizontal cells/units a Car takes up within the grid. */
  static final int NUM_CELLS = 2;

  /** The fixed speed that a Car travels. */
  static final int SPEED = 175;

  /** The respawn rate of a Car */
  static final MIN_RESPAWN_TIME = 2.0;

  /** Car's constructor, which calls Vehicle's constructor */
  Car(Color color, int cellWidth, int height, int offset) :
    super(cellWidth * NUM_CELLS, height, offset, getCarImage(color));

  /** Returns the appropriate image file to render within the scene, depending
   * on the given Color.
   * @param color: A value of the Color enum.
   * @return An ImageElement with the relative path to the appropriate file.
   */
  static ImageElement getCarImage(Color color) {
    // TODO Cite https://www.dartlang.org/resources/dart-tips/dart-tips-ep-8
    switch (color) {
      case Color.BLUE:
        return new ImageElement(src: "images/blueCar.png");
      case Color.GREEN:
        return new ImageElement(src: "images/greenCar.png");
      case Color.YELLOW:
        return new ImageElement(src: "images/yellowCar.png");
      default:
        // TODO Cite https://www.dartlang.org/resources/dart-tips/dart-tips-ep-9
        throw new StateError("Invalid car color");
    }
  }
}