import 'dart:typed_data';

import 'package:image/image.dart';

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

Uint8List reformat({
  required int width,
  required int height,
  required Uint8List processedImage,
}) {
  return Uint8List.fromList(
    encodePng(Image.fromBytes(width, height, processedImage)),
  );
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
  return <List<int>>[]; // TODO: Implement Rotation
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
  return <List<int>>[]; // TODO: Implement Reflection
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
