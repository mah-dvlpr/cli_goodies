import 'dart:io';

import 'package:cli_goodies/cli_goodies.dart';
import 'package:test/test.dart';

void main() {
  test('animate', () async {
    print('Starting computation 1...');
    await startSpinner(SpinnerType.dice);
    sleep(Duration(seconds: 2)); // Emulating demanding computation.
    stopSpinner();
  });
}