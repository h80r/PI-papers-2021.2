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

  // final originalPixels = originalImage.getBytes().toList();
  // final newPixels = <int>[];

  final newImage = Image.from(originalImage);

  for (var y = 0; y < height; y++) {
    for (var x = 0; x < width; x++) {
      final newPixel = originalImage.getPixelSafe(x + moveX, y + moveY);

      newImage.setPixel(
        x,
        y,
        newPixel == 0 ? int.parse('FF000000', radix: 16) : newPixel,
      );
    }
  }

  return Uint8List.fromList(encodePng(newImage));

  // return reformat(
  //   {'width': width, 'height': height},
  //   Uint8List.fromList(newPixels),
  // );
}

void rotation() {}

void scale() {}

void reflection() {}
