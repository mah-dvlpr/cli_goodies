import 'dart:io';

import 'package:cli_goodies/cli_goodies.dart';

void main() async {
    await animationStart();
    sleep(Duration(seconds: 10)); // Emulating demanding computation.
    animationStop();
  }