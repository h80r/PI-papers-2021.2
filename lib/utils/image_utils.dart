import 'dart:typed_data';

import 'package:image/image.dart';

/// Formats the [processedImage] to a [Uint8List] readable by Image widgets.
///
/// Parameters:
/// - `width`: The width of the image.
/// - `height`: The height of the image.
/// - `processedImage`: The image to be formatted.
/// - `format`: The desired format of the image.
///
/// Returns:
/// - An [Uint8List] with the image data.
Uint8List reformat({
  required int width,
  required int height,
  required Uint8List processedImage,
  Format format = Format.rgba,
}) {
  return Uint8List.fromList(
    encodePng(Image.fromBytes(width, height, processedImage, format: format)),
  );
}

/// Gets a pixel's neighborhood.
///
/// Parameters:
/// - `imageLuminanceMatrix`: 2D matrix of an image's luminance values;
/// - `y`: pixel's line position;
/// - `x`: pixel's column position;
/// - `neighborhoodSize`: Size of intended neighborhood (e.g. 3, 5, 7...).
///
/// Returns:
/// - `neighborhood`: 1D list containing the pixel[`y`][`x`]'s neighborhood.
List<int> getNeighborhood({
  required List<Uint8List> imageLuminanceMatrix,
  required int yPosition,
  required int xPosition,
  required int neighborhoodSize,
  bool isConvolution = false,
}) {
  /// neighborhoodGroup works as the neighborhood limits (lower and upper)
  final neighborhoodGroup = (neighborhoodSize - 1) ~/ 2;
  final neighborhood = <int>[];
  final imageHeight = imageLuminanceMatrix.length;
  final imageWidth = imageLuminanceMatrix[0].length;

  for (var y = yPosition - neighborhoodGroup;
      y <= yPosition + neighborhoodGroup;
      y++) {
    for (var x = xPosition - neighborhoodGroup;
        x <= xPosition + neighborhoodGroup;
        x++) {
      try {
        neighborhood.add(imageLuminanceMatrix[y][x]);
      } catch (_) {
        if (isConvolution) {
          final newY = y < 0 ? imageHeight + y : y % imageHeight;
          final newX = x < 0 ? imageWidth + x : x % imageWidth;

          neighborhood.add(
            imageLuminanceMatrix[newY][newX],
          );
        } else {
          neighborhood.add(-1);
        }
      }
    }
  }

  return neighborhood;
}
