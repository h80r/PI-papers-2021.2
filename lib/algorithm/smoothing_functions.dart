import 'dart:typed_data';

/// Converts a 1D list of pixels into a 2D matrix
/// that follows an image's shape.
///
/// Parameters:
/// - `imageLuminanceList`: 1D list of image's luminance values;
/// - `imageWidth`: image's width.
///
/// Returns:
/// - `imageMatrix`: 2D matrix of image's luminance values.
List<Uint8List> convertListToMatrix(
  Uint8List imageLuminanceList,
  int imageWidth,
) {
  final imageHeight = imageLuminanceList.length ~/ imageWidth;
  final imageMatrix = <Uint8List>[];

  for (var i = 0; i < imageHeight; i++) {
    imageMatrix.add(
      imageLuminanceList.sublist(
        imageWidth * i,
        imageWidth * (i + 1),
      ),
    );
  }

  return imageMatrix;
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
List<int> getNeighborhood(
  List<Uint8List> imageLuminanceMatrix,
  int yPosition,
  int xPosition,
  int neighborhoodSize,
) {
  // neighborhoodGroup works as the neighborhood limits (lower and upper)
  final neighborhoodGroup = (neighborhoodSize - 1) ~/ 2;
  final neighborhood = <int>[];

  for (var y = yPosition - neighborhoodGroup;
      y <= yPosition + neighborhoodGroup;
      y++) {
    for (var x = xPosition - neighborhoodGroup;
        x <= xPosition + neighborhoodGroup;
        x++) {
      try {
        neighborhood.add(imageLuminanceMatrix[y][x]);
      } catch (_) {}
    }
  }

  return neighborhood;
}

/// Applys a mask to a neighborhood.
///
/// Parameters:
/// - `mask`: List containing mask values;
/// - `neighborhood`: List of pixel values to be processed;
/// - `edgeSolution`: The chosen edge solution, in case there are not enough pixel values.
///
/// Returns:
/// - A number representing the new image's pixel value.
num applyMask(List mask, List neighborhood, Function edgeSolution) {
  if (mask.length == neighborhood.length) {
    var maskSum = mask.reduce((a, b) => a + b);
    num pixelSum = 0;
    for (var position = 0; position < mask.length; position++) {
      pixelSum += mask[position] * neighborhood[position];
    }
    return pixelSum ~/ maskSum;
  }
  return edgeSolution(neighborhood);
}
