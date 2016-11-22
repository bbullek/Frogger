//part of main;
//
//class Car {
//  /** The Car's image */
//  ImageElement _carImg;
//
//  /** The width (in pixels) of the Car. */
//  int _width;
//
//  /** The height (in pixels) of the Car. */
//  int _height;
//
//  /** The offset (in pixels) from the left of the Lane containing this Car. */
//  int _offset;
//
//  /** Car's constructor */
//  Car(Color color, Direction direction, int width, int height, int offset) {
//    _carImg = getCarImage(color, direction);
//    _width = width;
//    _height = height;
//    _offset = offset;
//  }
//
//  /* Getters and setters */
//  int get width => _width;
//
//  int get height => _height;
//
//  int get offset => _offset;
//
//  /** Returns the appropriate image file to render within the scene, depending
//   * on the given Color.
//   * @param color: A value of the Color enum.
//   * @return An ImageElement with the relative path to the appropriate file.
//   */
//  ImageElement getCarImage(Color color, Direction direction) {
//    if (direction == Direction.LEFT) {
//      // TODO Cite https://www.dartlang.org/resources/dart-tips/dart-tips-ep-8
//      switch (color) {
//        case Color.BLUE:
//          return new ImageElement(src: "images/blueCarLeft.png");
//        case Color.GREEN:
//          return new ImageElement(src: "images/greenCarLeft.png");
//        case Color.YELLOW:
//          return new ImageElement(src: "images/yellowCarLeft.png");
//        default:
//          throw new StateError("Invalid car color");
//      }
//    }
//
//    if (direction == Direction.RIGHT) {
//      switch (color) {
//        case Color.BLUE:
//          return new ImageElement(src: "images/blueCarRight.png");
//        case Color.GREEN:
//          return new ImageElement(src: "images/greenCarRight.png");
//        case Color.YELLOW:
//          return new ImageElement(src: "images/yellowCarRight.png");
//        default:
//          throw new StateError("Invalid car color");
//      }
//    }
//  }
//
//  /**
//   * Makes the Car move in the given direction by the given amount.
//   * @param direction: A member of the Direction enum -- LEFT/RIGHT/UP/DOWN.
//   * @param delta: The value by which to move the Frog in the given direction.
//   */
//  // TODO: This could be a method inherited from a Vehicle class
//  void move(Direction direction, int delta) {
//    if (direction == Direction.LEFT) _offset -= delta;
//    if (direction == Direction.RIGHT) _offset += delta;
//  }
//
//  /**
//   * Updates the given context by rendering the Car on the screen.
//   * @param context: The 2D context used to render images on the HTML canvas.
//   * @param laneOffset: The distance (in pixels) this Car's corresponding Lane
//   *        sits from the top of the screen.
//   */
//  void draw(CanvasRenderingContext2D context, int laneOffset) {
//    _carImg.onLoad.listen((e) {
//      // TODO Cite: https://api.dartlang.org/stable/1.20.1/dart-html/CanvasRenderingContext2D/drawImageScaled.html
//      context.drawImageScaled(_carImg, _offset, laneOffset, _width, _height);
//    });
//    context.drawImageScaled(_carImg, _offset, laneOffset, _width, _height);
//  }
//}