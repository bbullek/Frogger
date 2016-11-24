part of main;

/**
 * Logs float along the odd-numbered lanes within the game world and help
 * Frogger cross the River.
 */
class Log extends RiverObject {
  /** The fixed speed that a Log travels. */
  static final int SPEED = 175;

  /** The respawn rate of a Car */
  static final MIN_RESPAWN_TIME = 2.5;

  /** The RNG that will randomly select the length of a Log. */
  static final Random RANDOM = new Random();

  /** The Direction in which a Log travels. */
  static final DIR = Direction.LEFT;

  /** Log's constructor, which calls RiverObject's constructor */
  Log(Size size, int cellWidth, int height, int offset) :
        super(cellWidth * (size.index + 2), height, offset, getLogImage(size));

  /**
   * Returns the appropriate image file to render within the scene, depending
   * on the given Size of the Log.
   * @param color: A value of the Size enum.
   * @return An ImageElement with the relative path to the appropriate file.
   */
  static ImageElement getLogImage(Size size) {
    // TODO Cite https://www.dartlang.org/resources/dart-tips/dart-tips-ep-8
    switch (size) {
      case Size.SMALL:
        return new ImageElement(src: "images/smallLog.png");
      case Size.MEDIUM:
        return new ImageElement(src: "images/mediumLog.png");
      case Size.LARGE:
        return new ImageElement(src: "images/largeLog.png");
      default:
      // TODO Cite https://www.dartlang.org/resources/dart-tips/dart-tips-ep-9
        throw new StateError("Invalid log size");
    }
  }

  /**
   * Returns a random value of the Size enum for generating Logs of assorted
   * sizes.
   */
  static Size getRandomSize() {
    int randIndex = Log.RANDOM.nextInt(Size.values.length);
    return Size.values[randIndex];
  }
}