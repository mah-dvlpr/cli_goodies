import 'dart:io';

import 'package:cli_goodies/cli_goodies.dart';
import 'package:test/test.dart';

void main() {
  test('animate', () async {
    await animationStart();
    sleep(Duration(seconds: 10)); // Emulated demanding computation.
    animationStop();
  });
}