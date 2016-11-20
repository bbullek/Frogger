part of main;

// TODO Cite:
// http://herrrattentod.deviantart.com/art/TUTORIAL-SPRITES-Frogger-with-Unity-Playmaker-SPRI-580610502
// for image

/**
 * The Frogger character, who is represented with a .png image and has various
 * states (including animation frame and position).
 */
class Frog {
  /** Frogger's image */
  ImageElement _frogImg;

  /** The width (in pixels) of the Frog. */
  int _width;

  /** The height (in pixels) of the Frog. */
  int _height;

  /** The offset (in pixels) from the left of the screen to draw the Frog. */
  int _xLoc;

  /** The offset (in pixels) from the top of the screen to draw the Frog. */
  int _yLoc;

  // Frog's constructor
  Frog(int width, int height, int xLoc, int yLoc) {
    _width = width;
    _height = height;
    _xLoc = xLoc;
    _yLoc = yLoc;
    _frogImg = new ImageElement(src: "images/frog1.png");
  }

  /**
   * Updates the given context by rendering the Frog on the screen.
   */
  void draw(CanvasRenderingContext2D context) {
    _frogImg.onLoad.listen((e) {
      // TODO Cite: https://api.dartlang.org/stable/1.20.1/dart-html/CanvasRenderingContext2D/drawImageScaled.html
      context.drawImageScaled(_frogImg, _xLoc, _yLoc, _width, _height);
    });
  }
}