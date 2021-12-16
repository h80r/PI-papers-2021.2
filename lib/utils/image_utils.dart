import 'dart:math';
import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:pi_papers_2021_2/utils/list_util.dart';

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

// TODO: Add documentation
double _sum(double a, double b) => a + b;

final _memoizedLaplace = <int, List<List<int>>>{};
// TODO: Add documentation
List<List<int>> getLaplaceKernel(int radius) {
  if (_memoizedLaplace.containsKey(radius)) {
    return _memoizedLaplace[radius]!;
  }
  print('calculou laplace');
  final size = radius * 2 + 1;

  final kernel = List.generate(
    size,
    (row) => List.generate(size, (column) => -1),
  );

  final limit = kernel.length ~/ 3;

  for (var y = limit; y < limit * 2; y++) {
    for (var x = limit; x < limit * 2; x++) {
      kernel[y][x] *= -8;
    }
  }

  _memoizedLaplace[radius] = kernel;
  return kernel;
}

// TODO: Add documentation
double _gaussian(int x, int mu, double sigma) {
  return exp(-pow(((x - mu) / (sigma)), 2) / 2);
}

// TODO: Add documentation
List<List<int>> getGaussianKernel(int radius, double sigma) {
  final horizontalKernel = [
    for (int x in Iterable.generate(2 * radius + 1)) _gaussian(x, radius, sigma)
  ];

  final verticalKernel = [...horizontalKernel];

  final basicKernel = [
    for (final xv in verticalKernel)
      [for (final xh in horizontalKernel) xv * xh]
  ];

  final kernelSum = basicKernel.map((line) => line.reduce(_sum)).reduce(_sum);

  final normalizedKernel =
      basicKernel.map((line) => line.map((value) => value / kernelSum));

  final kernelMin =
      normalizedKernel.map((line) => line.reduce(min)).reduce(min);

  final kernel = normalizedKernel
      .map((line) => line.map((value) => value ~/ kernelMin).toList())
      .toList();

  return kernel;
}

// TODO: Add documentation
List<List<int>> getLoGKernel(int radius, double sigma) {
  final gaussianKernel = getGaussianKernel(radius, sigma);
  final laplacianKernel = getLaplaceKernel(radius);

  return gaussianKernel * laplacianKernel;
}

void main(List<String> args) {
  for (final line in getGaussianKernel(4, 1.4)) {
    print([for (final x in line) x]);
  }
}
