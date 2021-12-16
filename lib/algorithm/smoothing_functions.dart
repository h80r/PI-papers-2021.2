import 'dart:math';
import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:pi_papers_2021_2/models/mask.dart';
import 'package:pi_papers_2021_2/utils/image_utils.dart';

typedef EdgeSolution = List<int> Function(Map<String, dynamic> parameters);

/// Applys a mask to a neighborhood.
///
/// Parameters:
/// - `mask`: List containing mask values;
/// - `neighborhood`: List of pixel values to be processed;
///
/// Returns:
/// - A number representing the new image's pixel value
/// if `neighborhood` has the same size of `mask`, or null otherwise.
int applyMask(List<int> mask, List<int> neighborhood) {
  final maskSum = mask.reduce((a, b) => a + b);
  var pixelSum = 0;

  for (var position = 0; position < mask.length; position++) {
    pixelSum += mask[position] * neighborhood[position];
  }

  return pixelSum ~/ maskSum;
}

/// Applys the replication solution to a neighborhood.
///
/// Parameters:
/// - `pixelValue`: Value of the pixel to be processed;
/// - `size`: The desired list size;
///
/// Returns:
/// - `pixelList`: A new neighborhood with every pixel being the original pixel.
List<int> replicationSolution(Map<String, dynamic> parameters) {
  final size = parameters['size'] as int;
  final pixelValue = parameters['pixelValue'] as int;

  return List.generate(size, (index) => pixelValue);
}

/// Applys the zero solution to a neighborhood.
///
/// Parameters:
/// - `size`: The desired list size;
///
/// Returns:
/// - A new neighborhood with 0 on all pixels.
List<int> zeroSolution(Map<String, dynamic> parameters) {
  final size = parameters['size'] as int;

  return List.generate(size, (index) => 0);
}

/// Applys the zero padding solution to a neighborhood.
///
/// Parameters:
/// - `neighborhood`: List of pixel values to be processed;
///
/// Returns:
/// - A new neighborhood with 0 on inexistent pixels.
List<int> paddingSolution(Map<String, dynamic> parameters) {
  final neighborhood = parameters['neighborhood'] as List<int>;

  return neighborhood.map((e) => e == -1 ? 0 : e).toList();
}

/// Applys the periodic convolution solution to a neighborhood.
///
/// Parameters:
/// - `size`: The desired list size;
/// - `position`: The position of the pixel to be processed;
/// - `imagePixels`: The image's pixels;
///
/// Returns:
/// - A new neighborhood with valid pixels.
List<int> convolutionSolution(Map<String, dynamic> parameters) {
  final imagePixels = parameters['imagePixels'] as List<Uint8List>;
  final position = parameters['position'] as Point;
  final size = parameters['size'] as int;

  return getNeighborhood(
    imageLuminanceMatrix: imagePixels,
    yPosition: position.y.toInt(),
    xPosition: position.x.toInt(),
    neighborhoodSize: size,
    isConvolution: true,
  );
}

/// Applies the smoothing operation to an image.
///
/// Parameters:
/// - `image`: List of image's bytes;
/// - `mask`: List containing mask values;
/// - `neighborhoodSize`: Size of intended neighborhood (e.g. 3, 5, 7...).
/// - `edgeSolution`: The chosen edge solution, in case there are not enough pixel values.
///
/// Returns:
/// - List of new image's bytes after smoothing operation.
Uint8List? operate(
  Uint8List? image,
  Mask? mask,
  int? neighborhoodSize,
  EdgeSolution? edgeSolution,
) {
  if (image == null ||
      mask == null ||
      neighborhoodSize == null ||
      edgeSolution == null) return null;

  final img = decodeImage(image)!;

  final imagePixels = convertListToMatrix(
    img.getBytes(format: Format.luminance),
    img.width,
  );

  final newImagePixels = <int>[];

  for (var y = 0; y < imagePixels.length; y++) {
    for (var x = 0; x < imagePixels[0].length; x++) {
      var neighborhood = getNeighborhood(
        imageLuminanceMatrix: imagePixels,
        yPosition: y,
        xPosition: x,
        neighborhoodSize: neighborhoodSize,
        isConvolution: edgeSolution == convolutionSolution,
      );

      final desiredLength = pow(neighborhoodSize, 2);

      if (edgeSolution != convolutionSolution) {
        if (neighborhood.any((pixel) => pixel == -1)) {
          neighborhood = edgeSolution(
            {
              'pixelValue': imagePixels[y][x],
              'size': desiredLength,
              'neighborhood': neighborhood,
              'imagePixels': imagePixels,
              'position': Point(x, y),
            },
          );
        }
      }

      newImagePixels.add(applyMask(mask.asList(), neighborhood));
    }
  }

  return reformat(
    width: img.width,
    height: img.height,
    processedImage: Uint8List.fromList(newImagePixels),
    format: Format.luminance,
  );
}
