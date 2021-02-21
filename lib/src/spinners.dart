import 'dart:io';
import 'dart:async';
import 'dart:isolate';

enum SpinnerType { snake, dice, clock }

/// Active isolate object. Is created when [startSpinner()] is called.
Isolate _spinnerIsolate;

/// Starts an animation on a new line.
Future<Isolate> startSpinner(SpinnerType type) async {
  stdout.write('\x1B[?25l'); // Hide the cursor.
  return _spinnerIsolate ?? (_spinnerIsolate = await Isolate.spawn(_animate, type));
}

/// Stops current spinner animation by killing the isolate instance,
/// and clears current line.
void stopSpinner() {
  _spinnerIsolate.kill(priority: Isolate.immediate);
  _spinnerIsolate = null;
  stdout.write('\x1B[2K\x1B[1G'); // Clear current line, and move to first col.
  stdout.write('\x1B[?25h'); // Unhide the cursor.
}

/// Run the animation of active [_spinnerIsolate].
/// 
/// The [sp] is ignored, and can be set to null.
Future<void> _animate(SpinnerType type) async {
  _Spinner(type).animate();
}

/// Base (abstract) class of all cli spinners.
///
/// The [frames] field holds each individual frame of an animation, whilst the
/// [frame_period] represents the sleep time between each frame.
abstract class _Spinner {
  final frames;
  final frame_period;

  _Spinner._(this.frames, this.frame_period);

  factory _Spinner(SpinnerType type) {
    switch (type) {
      case SpinnerType.snake:
        return _Snake();
      case SpinnerType.dice:
        return _Dice();
      case SpinnerType.clock:
        return _Clock();
      default:
        return _Snake();
    }
  }

  /// Animate the spinnner.
  void animate() {
    var frame = 0;
    while (true) {
      stdout.write(frames[frame]);
      frame = (frame + 1) % frames.length;
      sleep(Duration(milliseconds: frame_period));
      stdout.write('\x1B[2K\x1B[1G'); // Clear line and put cursor at col 1.
    }
  }
}

class _Snake extends _Spinner {
  static const _frames = ['⠁', '⠂', '⠄', '⡀', '⢀', '⠠', '⠐', '⠈'];
  static const _frame_period = 100;

  _Snake() : super._(_frames, _frame_period);

  void _nextFrame(int frame) {
    stdout.write('\x1B[1m${frames[frame]}\x1B[m');
  }

  void _clearFrame() {
    stdout.write('\x1B[2K\x1B[1G');
  }

  /// Animate the spinnner.
  @override
  void animate() {
    var baseFrame = 0;

    while (true) {
      for (var frame = baseFrame;
          frame < stdout.terminalColumns ~/ 2 + baseFrame;
          frame++) {
        _nextFrame(frame % frames.length);
      }
      baseFrame = (baseFrame + 1) % frames.length;
      sleep(Duration(milliseconds: frame_period));
      _clearFrame();
    }
  }
}

class _Dice extends _Spinner {
  static const _frames = ['⚀', '⚁', '⚂', '⚃', '⚄', '⚅'];
  static const _frame_period = 500;

  _Dice() : super._(_frames, _frame_period);
}

class _Clock extends _Spinner {
  static const _frames = [
    '🕐',
    '🕑',
    '🕒',
    '🕓',
    '🕔',
    '🕕',
    '🕖',
    '🕗',
    '🕘',
    '🕙',
    '🕚',
    '🕛'
  ];
  static const _frame_period = 500;

  _Clock() : super._(_frames, _frame_period);
}
