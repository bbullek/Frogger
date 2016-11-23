library main;

import 'dart:html';
import 'dart:js';
import 'dart:math';
import 'dart:async';
import 'dart:collection';

part 'Keyboard.dart';
part 'GameHost.dart';
part 'Scene.dart';
part 'Frog.dart';
part 'Lane.dart';
part 'Vehicle.dart';
part 'Car.dart';
part 'Truck.dart';
part 'FireEngine.dart';
part 'Color.dart';
part 'Direction.dart';
part 'GameOverException.dart';

void main() {
  final CanvasElement canvas = querySelector("#area");
  canvas.focus();
  scheduleMicrotask(new GameHost(canvas).run);
}