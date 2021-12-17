import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:pi_papers_2021_2/algorithm/smoothing_functions.dart';
import 'package:pi_papers_2021_2/utils/image_utils.dart';
import 'package:pi_papers_2021_2/utils/spatial_enum.dart';

int applyLaplace(List<int> neighborhood) {
  const mask = [-1, -1, -1, -1, 8, -1, -1, -1, -1];

  var index = 0;
  final sum = neighborhood.fold<int>(
    0,
    (sum, value) => sum + value * mask[index++],
  );

  return sum ~/ 9;
}

Uint8List? operate(
  Uint8List? image,
  Map<SpatialFilters, bool>? filters,
  double? sigma,
) {
  if (image == null || filters == null || sigma == null) return null;

  final decodedImage = decodeImage(image)!;

  final imagePixels = convertListToMatrix(
    decodedImage.getBytes(format: Format.luminance),
    decodedImage.width,
  );

  final newImagePixels = <int>[];

  for (var y = 0; y < imagePixels.length; y++) {
    for (var x = 0; x < imagePixels[0].length; x++) {
      final neighborhood = getNeighborhood(
        imageLuminanceMatrix: imagePixels,
        yPosition: y,
        xPosition: x,
        neighborhoodSize: 3,
        isConvolution: true,
      );

      newImagePixels.add(applyLaplace(neighborhood));
    }
  }

  return reformat(
    width: decodedImage.width,
    height: decodedImage.height,
    processedImage: Uint8List.fromList(newImagePixels),
    format: Format.luminance,
  );
}
