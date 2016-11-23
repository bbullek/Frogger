part of main;

// TODO Cite https://www.dartlang.org/guides/language/language-tour#exceptions
// TODO Cite http://stackoverflow.com/questions/13579982/custom-exceptions-in-dart

/**
 * A custom exception raised when Frogger is squished by a vehicle, drowns, or
 * is carried offscreen by a floating object.
 */
class GameOverException implements Exception {
  String cause;
  GameOverException(cause);
}
