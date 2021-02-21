import 'dart:io';

import 'package:cli_goodies/cli_goodies.dart';

void main() async {
    await animationStart();
    // Start Your demanding computation.
    sleep(Duration(seconds: 10));
    // Computation is over.
    animationStop();
    sleep(Duration(seconds: 5));
  }