import 'package:flutter/foundation.dart';

String path(str) {
  return (kIsWeb && !kDebugMode) ? 'assets/$str' : str;
}
