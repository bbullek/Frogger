part of main;

// Cite:
// http://stackoverflow.com/questions/11599113/how-to-load-an-image-in-dart

/**
 * The representation of the game's current scene, including background image,
 * objects loaded into the game, etc.
 */
class Scene {
  /** The game's background image */
  ImageElement _background;

  // Scene's constructor
  Scene() {
    _background = new ImageElement(src: "images/background.png");
  }

  /**
   * Updates the given context by drawing the active elements.
   */
  void draw(CanvasRenderingContext2D context) {
    _background.onLoad.listen((e) {
      context.drawImage(_background, 0, 0);
    });
  }
}