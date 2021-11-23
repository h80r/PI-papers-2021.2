import 'dart:typed_data';

import 'package:image/image.dart';

Uint8List reformat(Map<String, int> measurements, Uint8List processedImage) {
  return Uint8List.fromList(
    encodePng(
      Image.fromBytes(
        measurements['width'] ?? 0,
        measurements['height'] ?? 0,
        processedImage,
        format: Format.luminance,
      ),
    ),
  );
}

Uint8List? translation(Uint8List? imageData, int moveX, int moveY) {
  if (imageData == null) return null;

  final image = decodeImage(imageData)!;
  final width = image.width;
  final height = image.height;

  final positions = <Point>[];
  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      positions.add(Point(x + moveX, y + moveY));
    }
  }

  final originalPixels = image.getBytes(format: Format.luminance).toList();
  final newPixels = <int>[];

  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      final newPosition = positions.indexWhere((e) => e.x == x && e.y == y);
      if (newPosition == -1) {
        newPixels.add(0);
      } else {
        newPixels.add(originalPixels[newPosition]);
      }
    }
  }

  return reformat(
    {'width': width, 'height': height},
    Uint8List.fromList(newPixels),
  );
}

void rotation() {}

void scale() {}

void reflection() {}
