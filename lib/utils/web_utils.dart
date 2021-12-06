import 'package:flutter/foundation.dart';

/// Updates the  `originalPath` to work on deployed apps.
String path(String originalPath) {
  return (kIsWeb && !kDebugMode) ? 'assets/$originalPath' : originalPath;
}
