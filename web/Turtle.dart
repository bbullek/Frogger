part of main;

/**
 * Turtles float along the even-numbered lanes within the game world and help
 * Frogger cross the River.
 */
class Turtle extends RiverObject {
  /** The number of horizontal cells/units a Turtle takes up within the grid. */
  static final double NUM_CELLS = 1.5;

  /** The fixed speed that a Turtle travels. */
  static final int SPEED = 90;

  /** The respawn rate of a Turtle */
  static final MIN_RESPAWN_TIME = 3.8;

  /** The Direction in which a Turtle travels. */
  static final DIR = Direction.RIGHT;

  /** Turtle's constructor, which calls RiverObject's constructor */
  Turtle(int cellWidth, int height, int offset) :
        super((cellWidth * NUM_CELLS).toInt(), height, offset, getTurtleImage());

  /** Returns the appropriate image file to render within the scene.
   * @return An ImageElement with the relative path to the appropriate file.
   */
  static ImageElement getTurtleImage() {
    return new ImageElement(src: "images/turtle.png");
  }
}