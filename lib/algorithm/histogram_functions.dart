import 'dart:typed_data';

import 'package:image/image.dart';

/// Returns specific histogram operation according to `dropdownCurrentValue` parameter.
// TODO: Se as funções tiverem retornos diferentes, é aconselhado definir a getOperation como dynamic ao invés de Function(<retornos>)
// Function() getOperation(String dropdownCurrentValue) {
//   switch (dropdownCurrentValue) {
//     case 'Histograma':
//       return getHistogram;
//     case 'Histograma normalizado':
//       return getNormalizedHistogram;
//     case 'Equalização de histograma':
//       return histogramEqualization;
//     default:
//       return contrastStreching;
//   }
// }

/// Reads the provided image, and returns the
/// luminance value of each pixel as a list.
Uint8List getPixelsLuminanceValues(Uint8List imageA) {
  return decodeImage(imageA)!.getBytes(format: Format.luminance);
}

/// Creates a Map associating each pixel value to its frequency (quantity) in image.
///
/// Parameters:
/// - `imageA`: uploaded image.
///
/// Returns:
/// - `intensityFrequency`: Map containing each pixel value
/// associated to its frequency in `getPixelsLuminanceValues()`.
Map<int, num>? getHistogram(Uint8List? imageA) {
  if (imageA == null) return null;
  final intensityFrequency = <int, num>{};

  for (final v in getPixelsLuminanceValues(imageA)) {
    intensityFrequency.update(v, (value) => value + 1, ifAbsent: () => 1);
  }

  return intensityFrequency;
}

void getNormalizedHistogram() {}

void histogramEqualization() {}

void contrastStreching() {}
