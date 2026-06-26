import 'dart:math';
import 'dart:typed_data';

import 'package:base32/base32.dart';

class TotpService {
  static String generateSecret() {
    final random = Random.secure();

    final bytes = List<int>.generate(20, (_) => random.nextInt(256));

    return base32.encode(Uint8List.fromList(bytes));
  }
}
