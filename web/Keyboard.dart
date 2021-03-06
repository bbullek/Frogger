part of main;

/**
 * The set of keys that the user is actively pressing.
 */
class Keyboard {
  final HashSet<int> _keys = new HashSet<int>();

  /** Keyboard's constructor */
  Keyboard() {
    window.onKeyDown.listen((final KeyboardEvent e) {
          _keys.add(e.keyCode);
    });
    window.onKeyUp.listen((final KeyboardEvent e) {
      _keys.remove(e.keyCode);
    });
  }

  isPressed(final int keyCode) => _keys.contains(keyCode);
}