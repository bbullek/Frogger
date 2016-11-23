part of main;

/** Vehicles are a base class for Cars, Trucks, and FireEngines, which share
 * much of the same functionality.
 */
abstract class Vehicle {
  /** The width (in pixels) of the Vehicle. */
  int _width;

  /** The height (in pixels) of the Vehicle. */
  int _height;

  /** The pixel offset from the left of the Lane containing this Vehicle. */
  int _offset;

  /** The Vehicle's image */
  ImageElement _vehicleImg;

  /** Vehicle's constructor */
  Vehicle(int width, int height, int offset, ImageElement vehicleImg) {
    _width = width;
    _height = height;
    _offset = offset;
    _vehicleImg = vehicleImg;
  }

  /* Getters and setters */
  int get width => _width;

  int get height => _height;

  int get offset => _offset;
  /* End of getters and setters */

  /**
   * Returns the speed of the given Vehicle object.
   * @param vehicle: An instance of a Car, Truck, or FireEngine
   * @return The integer value of the Vehicle's speed
   */
  static int getSpeed(Vehicle vehicle) {
    if (vehicle is Car) return Car.SPEED;
    if (vehicle is Truck) return Truck.SPEED;
    if (vehicle is FireEngine) return FireEngine.SPEED;
  }

  /**
   * Makes the Vehicle move within the Lane by the given amount.
   * @param delta: The value by which to move the Vehicle.
   */
  void move(int delta) {
    if (this is Car) {
      _offset -= delta;
    } else {
      _offset += delta;
    }
  }

  /**
   * Updates the given context by rendering the Vehicle on the screen.
   * @param context: The 2D context used to render images on the HTML canvas.
   * @param laneOffset: The distance (in pixels) this Vehicle's corresponding
   *        Lane sits from the top of the screen.
   */
  void draw(CanvasRenderingContext2D context, int laneOffset) {
    _vehicleImg.onLoad.listen((e) {
      // TODO Cite: https://api.dartlang.org/stable/1.20.1/dart-html/CanvasRenderingContext2D/drawImageScaled.html
      context.drawImageScaled(_vehicleImg, _offset, laneOffset, _width, _height);
    });
    context.drawImageScaled(_vehicleImg, _offset, laneOffset, _width, _height);
  }
}