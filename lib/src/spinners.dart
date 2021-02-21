import 'dart:io';

enum SpinnerType { snake, dice, clock }

/// Base (abstract) class of all cli spinners.
///
/// The [frames] field holds each individual frame of an animation, whilst the
/// [frame_period] represents the sleep time between each frame.
abstract class Spinner {
  final frames;
  final frame_period;

  Spinner._(this.frames, this.frame_period);

  factory Spinner(SpinnerType type) {
    switch (type) {
      case SpinnerType.snake:
        return Snake();
      case SpinnerType.dice:
        return Dice();
      case SpinnerType.clock:
        return Clock();
      default:
        return Snake();
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

class Snake extends Spinner {
  static const _frames = ['⠁', '⠂', '⠄', '⡀', '⢀', '⠠', '⠐', '⠈'];
  static const _frame_period = 100;

  Snake() : super._(_frames, _frame_period);

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

class Dice extends Spinner {
  static const _frames = ['⚀', '⚁', '⚂', '⚃', '⚄', '⚅'];
  static const _frame_period = 500;

  Dice() : super._(_frames, _frame_period);
}

class Clock extends Spinner {
  static const _frames = [
    '🕐',
    '🕑',
    '🕒',
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

  Clock() : super._(_frames, _frame_period);
}
