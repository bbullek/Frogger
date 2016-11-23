part of main;

/**
 * FireEngines drive along the lane fourth from the top and should be avoided by
 * Frogger at all costs.
 */
class FireEngine extends Vehicle {
  /** The number of horizontal cells/units a FireEngine takes up. */
  static final int NUM_CELLS = 3;

  /** The fixed speed that a FireEngine travels. */
  static final int SPEED = 230;

  /** The respawn rate of a FireEngine */
  static final MIN_RESPAWN_TIME = 3.25;

  /** FireEngine's constructor, which calls Vehicle's constructor */
  FireEngine(int cellWidth, int height, int offset) :
        super(cellWidth * NUM_CELLS, height, offset, getFireEngineImage());

  /**
   * Returns the appropriate image file to render within the scene.
   * @return An ImageElement with the relative path to the appropriate file.
   */
  static ImageElement getFireEngineImage() {
    return new ImageElement(src: "images/fireEngine.png");
  }
}