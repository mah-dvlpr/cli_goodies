import 'dart:io';
import 'dart:async';
import 'dart:isolate';

import 'package:cli_goodies/src/spinners.dart';
export 'package:cli_goodies/src/spinners.dart';

/// Active isolate object. Is created when [animationStart()] is called.
Isolate _animationIsolate;

/// Starts an animation on a new line.
Future<Isolate> animationStart(SpinnerType type) async {
  stdout.write('\n');
  return _animationIsolate ?? (_animationIsolate = await Isolate.spawn(_animate, type));
}

/// Stops current animation by killing the isolate instance,
/// and clears current line.
void animationStop() {
  _animationIsolate.kill(priority: Isolate.immediate);
  _animationIsolate = null;
  stdout.write('\x1B[2K\x1B[1G'); // Clear current line, and move to first col.
}

/// Run the animation of active [_animationIsolate].
/// 
/// The [sp] is ignored, and can be set to null.
Future<void> _animate(SpinnerType type) async {
  Spinner(type).animate();
}