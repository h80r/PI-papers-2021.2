import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:pi_papers_2021_2/utils/histogram_utils.dart';

typedef HistogramData = Map<int, num>;
typedef HistogramResult = Tuple<HistogramData, Uint8List?>;
typedef HistogramFunction = HistogramResult Function(Uint8List luminanceList);

/// Reads the provided image, and returns the
/// luminance value of each pixel as a list.
Uint8List getLuminanceValues(Uint8List imageA) {
  return decodeImage(imageA)!.getBytes(format: Format.luminance);
}

HistogramResult? operate(Uint8List? image, HistogramFunction? operation) {
  if (image == null || operation == null) return null;

  final luminanceList = getLuminanceValues(image);
  return operation(luminanceList);
}

/// Creates a Map associating each pixel value to its frequency (quantity) in image.
///
/// Parameters:
/// - `imageA`: uploaded image.
///
/// Returns:
/// - `intensityFrequency`: Map containing each pixel value
/// associated to its frequency in `getPixelsLuminanceValues()`.
HistogramResult histogramGeneration(Uint8List luminanceList) {
  final intensityFrequency = <int, num>{};

  for (final v in luminanceList) {
    intensityFrequency.update(v, (value) => value + 1, ifAbsent: () => 1);
  }

  return Tuple(intensityFrequency, null);
}

HistogramResult normalizedHistogram(Uint8List? luminanceList) {
  return const Tuple({}, null);
}

HistogramResult histogramEqualization(Uint8List? luminanceList) {
  return const Tuple({}, null);
}

HistogramResult contrastStreching(Uint8List? luminanceList) {
  return const Tuple({}, null);
}
