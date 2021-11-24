import 'dart:math';
import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:pi_papers_2021_2/utils/image_utils.dart';

typedef GeometricFunction = List<List<int>> Function({
  required List<List<int>> imageMatrix,
  required Map<String, int> data,
});

List<int> bytesFromPixels(List<int> pixels) {
  return pixels
      .map((pixel) {
        final a = (pixel & 0xFF000000) >> 24;
        final b = (pixel & 0x00FF0000) >> 16;
        final g = (pixel & 0x0000FF00) >> 8;
        final r = pixel & 0x000000FF;
        return [r, g, b, a];
      })
      .expand((element) => element)
      .toList();
}

List<List<int>> imagePixelsFromData(Uint32List data, int height, int width) {
  final parsedData = data.toList();
  final matrix = <List<int>>[];

  for (var y = 0; y < height; y++) {
    final row = <int>[];
    for (var x = 0; x < width; x++) {
      row.add(parsedData.removeAt(0));
    }
    matrix.add(row);
  }

  return matrix;
}

List<List<int>> translation({
  required List<List<int>> imageMatrix,
  required Map<String, int> data,
}) {
  return List.generate(
    data['height']!,
    (y) => List.generate(
      data['width']!,
      (x) {
        try {
          return imageMatrix[y - data['moveY']!][x - data['moveX']!];
        } catch (e) {
          return 0xFF000000;
        }
      },
    ),
  );
}

List<List<int>> rotation({
  required List<List<int>> imageMatrix,
  required Map<String, int> data,
}) {
  final newImage = List.generate(
    data['height']!,
    (y) => List.generate(data['width']!, (x) => 0xFF000000),
  );

  final rads = data['rotation']! * pi / 180;

  for (var y = 0; y < data['height']!; y++) {
    for (var x = 0; x < data['width']!; x++) {
      final newX = x * cos(rads) + y * sin(rads);
      if (newX < 0 || newX >= data['width']!) continue;

      final newY = y * cos(rads) - x * sin(rads);
      if (newY < 0 || newY >= data['height']!) continue;

      newImage[newY.toInt()][newX.toInt()] = imageMatrix[y][x];
    }
  }

  return newImage;
}

List<List<int>> scale({
  required List<List<int>> imageMatrix,
  required Map<String, int> data,
}) {
  return <List<int>>[]; // TODO: Implement Scale
}

List<List<int>> reflection({
  required List<List<int>> imageMatrix,
  required Map<String, int> data,
}) {
  return List.generate(
    data['height']!,
    (y) => List.generate(
      data['width']!,
      (x) {
        final yCoord =
            data['reflectionType'] != 1 ? (y - (data['height']! - 1)).abs() : y;
        final xCoord =
            data['reflectionType'] != 2 ? (x - (data['width']! - 1)).abs() : x;

        return imageMatrix[yCoord][xCoord];
      },
    ),
  );
}

Uint8List? operate({
  required Uint8List? image,
  required Map<String, int>? inputs,
  required GeometricFunction? operation,
}) {
  if (image == null || inputs == null || operation == null) return null;

  final originalImage = decodeImage(image)!;
  inputs['width'] = originalImage.width;
  inputs['height'] = originalImage.height;

  return reformat(
    width: inputs['width']!,
    height: inputs['height']!,
    processedImage: Uint8List.fromList(
      bytesFromPixels(
        operation(
          imageMatrix: imagePixelsFromData(
            originalImage.data,
            inputs['height']!,
            inputs['width']!,
          ),
          data: inputs,
        ).expand((element) => element).toList(),
      ),
    ),
  );
}
