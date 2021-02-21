import 'dart:io';

import 'package:cli_goodies/cli_goodies.dart';

void main() async {
  print('Starting computation 1...');
  await animationStart(SpinnerType.dice);
  sleep(Duration(seconds: 2)); // Emulating demanding computation.
  animationStop();

  print('Starting computation 2...');
  await animationStart(SpinnerType.snake);
  sleep(Duration(seconds: 4)); // Emulating demanding computation.
  animationStop();

  print('Starting computation 3...');
  await animationStart(SpinnerType.clock);
  sleep(Duration(seconds: 8)); // Emulating demanding computation.
  animationStop();
  }