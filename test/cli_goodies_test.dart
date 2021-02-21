import 'dart:io';

import 'package:cli_goodies/cli_goodies.dart';
import 'package:test/test.dart';

void main() {
  test('animate', () async {
    await animationStart();
    // Start Your demanding computation.
    sleep(Duration(seconds: 10));
    // Computation is over.
    animationStop();
    sleep(Duration(seconds: 5));
  });
}