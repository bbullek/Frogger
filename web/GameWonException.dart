part of main;

// TODO Cite https://www.dartlang.org/guides/language/language-tour#exceptions
// TODO Cite http://stackoverflow.com/questions/13579982/custom-exceptions-in-dart

/**
 * A custom exception raised when Frogger has successfully reached each of the
 * five Lilypads at the top of the screen.
 */
class GameWonException implements Exception {
  String cause;
  GameWonException(cause);
}
