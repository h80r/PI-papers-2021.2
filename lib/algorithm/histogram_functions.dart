import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:pi_papers_2021_2/utils/histogram_utils.dart';
import 'package:pi_papers_2021_2/utils/image_utils.dart';

typedef HistogramData = Map<int, num>;
typedef HistogramResult = Tuple<HistogramData, Uint8List?>;
typedef HistogramFunction = HistogramResult Function(Uint8List luminanceList);

/// Reads the provided image, and returns the
/// luminance value of each pixel as a list.
Uint8List getLuminanceValues(Image decodedImage) {
  return decodedImage.getBytes(format: Format.luminance);
}

HistogramResult? operate(Uint8List? image, HistogramFunction? operation) {
  if (image == null || operation == null) return null;

  final decodedImage = decodeImage(image)!;
  final luminanceList = getLuminanceValues(decodedImage);

  final result = operation(luminanceList);

  if (result.get<Uint8List?>() == null) return result;
  return result.copyWith(
    second: reformat(
      width: decodedImage.width,
      height: decodedImage.height,
      processedImage: result.get<Uint8List?>()!,
    ),
  );
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
  return Tuple({}, null);
}

HistogramResult histogramEqualization(Uint8List? luminanceList) {
  final processedPixelList = luminanceList;
  return Tuple({}, processedPixelList);
}

HistogramResult contrastStreching(Uint8List? luminanceList) {
  final processedPixelList = luminanceList;
  return Tuple({}, processedPixelList);
}
