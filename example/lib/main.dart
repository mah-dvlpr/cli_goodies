import 'dart:io';

import 'package:cli_goodies/cli_goodies.dart';

void main() async {
  print('Starting computation 1...');
  await startSpinner(SpinnerType.dice);
  sleep(Duration(seconds: 2)); // Emulating demanding computation.
  stopSpinner();

  print('Starting computation 2...');
  await startSpinner(SpinnerType.snake);
  sleep(Duration(seconds: 4)); // Emulating demanding computation.
  stopSpinner();

  print('Starting computation 3...');
  await startSpinner(SpinnerType.clock);
  sleep(Duration(seconds: 8)); // Emulating demanding computation.
  stopSpinner();
  }