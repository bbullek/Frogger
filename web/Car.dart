part of main;

class Car {
  /** The number of horizontal cells/units a Car takes up within the grid. */
  static final int NUM_CELLS = 2;

  /** The fixed speed that a Car travels. */
  static final int SPEED = 150;

  /** The Car's image */
  ImageElement _carImg;

  /** The width (in pixels) of the Car. */
  int _width;

  /** The height (in pixels) of the Car. */
  int _height;

  /** The offset (in pixels) from the left of the Lane containing this Car. */
  int _offset;

  /** Car's constructor */
  Car(Color color, int cellWidth, int height, int offset) {
    _carImg = getCarImage(color);
    _width = cellWidth * NUM_CELLS;
    _height = height;
    _offset = offset;
  }

  /* Getters and setters */
  int get width => _width;

  int get height => _height;

  int get offset => _offset;
  /* End of getters and setters */

  /** Returns the appropriate image file to render within the scene, depending
   * on the given Color.
   * @param color: A value of the Color enum.
   * @return An ImageElement with the relative path to the appropriate file.
   */
  ImageElement getCarImage(Color color) {
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

  /**
   * Makes the Car move towards the left of the lane by the given amount.
   * @param delta: The value by which to move the Car.
   */
  // TODO: This could be a method inherited from a Vehicle class
  void move(int delta) {
    _offset -= delta;
  }

  /**
   * Updates the given context by rendering the Car on the screen.
   * @param context: The 2D context used to render images on the HTML canvas.
   * @param laneOffset: The distance (in pixels) this Car's corresponding Lane
   *        sits from the top of the screen.
   */
  void draw(CanvasRenderingContext2D context, int laneOffset) {
    _carImg.onLoad.listen((e) {
      // TODO Cite: https://api.dartlang.org/stable/1.20.1/dart-html/CanvasRenderingContext2D/drawImageScaled.html
      context.drawImageScaled(_carImg, _offset, laneOffset, _width, _height);
    });
    context.drawImageScaled(_carImg, _offset, laneOffset, _width, _height);
  }
}