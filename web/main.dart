library main;

import 'dart:html';
import 'dart:math';
import 'dart:async';
import 'dart:collection';

part 'Keyboard.dart';
part 'GameHost.dart';

void main() {
  final CanvasElement canvas = querySelector("#area");
  canvas.focus();
  scheduleMicrotask(new GameHost(canvas).run);
}