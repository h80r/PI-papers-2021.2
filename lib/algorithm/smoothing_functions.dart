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
List convertListToMatrix(
  Uint8List imageLuminanceList,
  int imageWidth,
) {
  int imageHeight = imageLuminanceList.length ~/ imageWidth;
  List imageMatrix = [];
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
List<num> getNeighborhood(
  List imageLuminanceMatrix,
  int yPosition,
  int xPosition,
  int neighborhoodSize,
) {
  // neighborhoodGroup works as the neighborhood limits (lower and upper)
  int neighborhoodGroup = (neighborhoodSize - 1) ~/ 2;
  List<num> neighborhood = [];
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

void operate2() {}
