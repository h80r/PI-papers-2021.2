import 'dart:math';
import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:pi_papers_2021_2/utils/list_utils.dart';

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

          neighborhood.add(imageLuminanceMatrix[newY][newX]);
        } else {
          neighborhood.add(-1);
        }
      }
    }
  }

  return neighborhood;
}

const laplaceMask = [-1, -1, -1, -1, 8, -1, -1, -1, -1];

double _laplacianOfGaussian(double sigma, double x, double y) {
  final laplace = -1 /
      (pi * pow(sigma, 4)) *
      (1 - (pow(x, 2) + pow(y, 2)) / (2 * pow(sigma, 2))) *
      exp(-(pow(x, 2) + pow(y, 2)) / (2 * pow(sigma, 2)));
  return laplace;
}

List<List<double>> _discreteLaplacianOfGaussian(double sigma, int n) {
  final kernel = [
    for (var _ in range(n)) [for (var _ in range(n)) 0.0]
  ];

  for (var y in range(n)) {
    for (var x in range(n)) {
      kernel[y][x] =
          _laplacianOfGaussian(sigma, (y - (n - 1) / 2), (x - (n - 1) / 2));
    }
  }

  return kernel;
}

List<List<int>> laplacianOfGaussian(double sigma) {
  Iterable<Iterable<int>> kernel;

  sigma = min(max(sigma, 0.5), 1.5);

  var currentScale = -1;
  while (true) {
    kernel = (_discreteLaplacianOfGaussian(sigma, 9) *
            (currentScale / _laplacianOfGaussian(sigma, 0, 0)))
        .map((e) => e.map((e) => e.round()));

    if (kernel.map((e) => e.reduce(sum)).reduce(sum) == 0) {
      break;
    }

    currentScale--;
  }

  return kernel.map((e) => e.toList()).toList();
}
