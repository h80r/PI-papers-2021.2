import 'dart:typed_data';

import 'package:image/image.dart';

Uint8List reformat(Map<String, int> measurements, Uint8List processedImage) {
  return Uint8List.fromList(
    encodePng(
      Image.fromBytes(
        measurements['width'] ?? 0,
        measurements['height'] ?? 0,
        processedImage,
      ),
    ),
  );
}

Uint8List? translation(Uint8List? imageData, int moveX, int moveY) {
  if (imageData == null) return null;

  final originalImage = decodeImage(imageData)!;
  final width = originalImage.width;
  final height = originalImage.height;

  // final positionMap = <List<Point>>[];
  // for (var y = 0; y < height; y++) {
  //   final row = <Point>[];
  //   for (var x = 0; x < width; x++) {
  //     row.add(Point(x + moveX, y + moveY));
  //   }
  //   positionMap.add(row);
  // }

  final originalPixels = originalImage.data.toList();

  final originalMatrix = <List<int>>[];
  for (var y = 0; y < height; y++) {
    final row = <int>[];
    for (var x = 0; x < width; x++) {
      row.add(originalPixels.removeAt(0));
    }
    originalMatrix.add(row);
  }

  final newMatrix = List.generate(
    height,
    (y) => List.generate(
      width,
      (x) {
        try {
          return originalMatrix[y - moveY][x - moveX];
        } catch (e) {
          return int.parse('FF000000', radix: 16);
        }
      },
    ),
  );

  final newPixels = newMatrix.expand((row) => row).toList();
  final newBytes = newPixels
      .map((pixel) {
        final a = (pixel & 0xFF000000) >> 24;
        final b = (pixel & 0x00FF0000) >> 16;
        final g = (pixel & 0x0000FF00) >> 8;
        final r = pixel & 0x000000FF;
        return [r, g, b, a];
      })
      .expand((element) => element)
      .toList();

  // final newPixels = <int>[];

  // final newImage = Image.from(originalImage);

  // for (var y = 0; y < height; y++) {
  //   for (var x = 0; x < width; x++) {
  //     final newPixel = originalImage.getPixelSafe(x + moveX, y + moveY);

  //     newImage.setPixel(
  //       x,
  //       y,
  //       newPixel == 0 ? int.parse('FF000000', radix: 16) : newPixel,
  //     );
  //   }
  // }

  // return Uint8List.fromList(encodePng(originalImage));

  return reformat(
    {'width': width, 'height': height},
    Uint8List.fromList(newBytes),
  );
}

void rotation() {}

void scale() {}

void reflection() {}
