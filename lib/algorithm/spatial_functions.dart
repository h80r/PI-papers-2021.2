import 'dart:math';
import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:pi_papers_2021_2/utils/image_utils.dart';
import 'package:pi_papers_2021_2/utils/list_util.dart';
import 'package:pi_papers_2021_2/utils/spatial_enum.dart';

typedef SpatialFilter = int Function(List<int> neighborhood, double sigma);

int laplaceFilter(List<int> neighborhood, double sigma) {
  final mask = getLaplaceKernel(sqrt(neighborhood.length) ~/ 2).flat;

  var index = 0;
  final sum = neighborhood.fold<int>(
    0,
    (sum, value) => sum + value * mask[index++],
  );

  return sum ~/ mask.length;
}

int gaussianFilter(List<int> neighborhood, double sigma) {
  final mask = getLoGKernel(sqrt(neighborhood.length) ~/ 2, sigma).flat;

  var index = 0;
  final sum = neighborhood.fold<int>(
    0,
    (sum, value) => sum + value * mask[index++],
  );

  return sum ~/ mask.length;
}

List<SpatialFilter> _processInput(Map<SpatialFilters, bool> allFilters) {
  final filters = {...allFilters}..removeWhere((key, value) => !value);
  return filters.keys.map((e) => e.asOperation()).toList();
}

Uint8List? operate(
  Uint8List? image,
  Map<SpatialFilters, bool>? allFilters,
  double? sigma,
) {
  if (image == null || allFilters == null || sigma == null) return null;

  final timer = Stopwatch()..start();
  final selectedFilters = _processInput(allFilters);

  final decodedImage = decodeImage(image)!;

  var initialPixels = convertListToMatrix(
    decodedImage.getBytes(format: Format.luminance),
    decodedImage.width,
  ).map((e) => e.toList()).toList();

  var stepPixels = List.generate(
    initialPixels.length,
    (row) => [...initialPixels[row]],
  );

  var totalSteps = 0;
  final expectedSteps = decodedImage.width * decodedImage.height;

  for (final filter in selectedFilters) {
    final isLaplace = filter == laplaceFilter;
    final imageLuminanceMatrix =
        initialPixels.map((e) => Uint8List.fromList(e)).toList();

    for (var y = 0; y < initialPixels.length; y++) {
      for (var x = 0; x < initialPixels[0].length; x++) {
        final neighborhood = getNeighborhood(
          imageLuminanceMatrix: imageLuminanceMatrix,
          yPosition: y,
          xPosition: x,
          neighborhoodSize: isLaplace ? 3 : 9,
          isConvolution: true,
        );

        stepPixels[y][x] = filter(neighborhood, sigma);
        totalSteps++;
      }
    }

    initialPixels = stepPixels;
  }
  timer.stop();

  print('$totalSteps | $expectedSteps');
  print('Time: ${timer.elapsed}');

  return reformat(
    width: decodedImage.width,
    height: decodedImage.height,
    processedImage: Uint8List.fromList(initialPixels.flat),
    format: Format.luminance,
  );
}
