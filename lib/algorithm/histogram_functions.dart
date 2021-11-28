import 'dart:math';
import 'dart:typed_data';

import 'package:image/image.dart';
import 'package:pi_papers_2021_2/utils/histogram_utils.dart';
import 'package:pi_papers_2021_2/utils/image_utils.dart';

typedef HistogramData = Map<int, num>;
typedef HistogramResult = Tuple<HistogramData, Uint8List?>;
typedef HistogramFunction = HistogramResult Function(Uint8List luminanceList);
const int graysQuantity = 256;

/// Reads the provided image, and returns the
/// luminance value of each pixel as a list.
Uint8List getLuminanceValues(Image decodedImage) {
  return decodedImage.getBytes(format: Format.luminance);
}

/// Returns the result of the histogram operation with an image.
///
/// The histogram is calculated by the [operation] function.
/// If the operation generates a new image, it will be encoded by this function.
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
      format: Format.luminance,
    ),
  );
}

/// Creates a Map associating each pixel value
/// to its frequency (quantity) in image.
///
/// Parameters:
/// - `luminanceList`: uploaded image.
///
/// Returns:
/// - A tuple with it's Uint8List as a null value and a map containing each
/// pixel value associated to its frequency in `luminanceList`.
HistogramResult histogramGeneration(Uint8List luminanceList) {
  final intensityFrequency = <int, num>{
    for (var l in List.generate(256, (i) => i)) l: 0
  };

  for (final v in luminanceList) {
    intensityFrequency.update(v, (value) => value + 1);
  }

  return Tuple(intensityFrequency, null);
}

HistogramResult normalizedHistogram(Uint8List luminanceList) {
  final histogramData = histogramGeneration(luminanceList).get<Map<int, num>>();

  final pixelCount = luminanceList.length;
  final normalizedFrequency = histogramData!.map(
    (key, value) => MapEntry(key, value / pixelCount),
  );

  return Tuple(normalizedFrequency, null);
}

HistogramResult contrastStreching(Uint8List luminanceList) {
  final oldHistogram = histogramGeneration(luminanceList).get<Map<int, num>>();

  const smallerIntervalValue = 0;
  const biggerIntervalValue = 255;

  final smallerImageValue = oldHistogram!.keys.toList().reduce(min);
  final biggerImageValue = oldHistogram.keys.toList().reduce(max);

  final newHistogram = oldHistogram.map((key, value) => MapEntry(
        ((key - smallerImageValue) *
                    ((biggerIntervalValue - smallerIntervalValue) /
                        (biggerImageValue - smallerImageValue)) +
                smallerIntervalValue)
            .toInt(),
        value,
      ));

  final luminanceMap = Map.fromIterables(oldHistogram.keys, newHistogram.keys);
  final processedPixelList = Uint8List.fromList(
    luminanceList.map((e) => luminanceMap[e]!).toList(),
  );

  return Tuple(newHistogram, processedPixelList);
}

/// Calculates `Pr(rk)` dividing each `nk` value by the total sum of `nk`.
///
/// Parameters:
/// - `nk`: image's histogram List.
///
/// Returns:
/// - `prRk`: each nk's probability.
List<num> getPrRk(List<num> nk) {
  List<num> prRk = [];
  num sumRk = nk.reduce((a, b) => a + b);
  for (num value in nk) {
    prRk.add(value / sumRk);
  }

  return prRk;
}

/// Calculates luminance `frequency` adding each `prRk` in a list to its next value.
///
/// Parameters:
/// - `prRk`: each nk's probability.
///
/// Returns:
/// - `prRk`: each nk's frequency.
List<num> getFrequency(List<num> prRk) {
  List<num> frequency = [];
  frequency.add(prRk[0]);
  for (int rk = 1; rk < graysQuantity; rk++) {
    frequency.add(prRk.sublist(0, rk + 1).reduce((a, b) => a + b));
  }
  return frequency;
}

/// Calculates `eq` multiplying each `frequency` in a list by max possible luminance value.
///
/// Parameters:
/// - `frequency`: each nk's frequency value.
///
/// Returns:
/// - `eq`: each nk's frequency multiplied by max possible luminance value.
List<num> getEq(List<num> frequency) {
  List<num> eq = [];
  for (num value in frequency) {
    eq.add((graysQuantity - 1) * value);
  }

  return eq;
}

/// Calculates `NewRk` getting the integer value of each `eq` value.
///
/// Parameters:
/// - `eq`: each nk's frequency multiplied by max possible luminance value.
///
/// Returns:
/// - `newRk`: new luminance value to be added in the result image.
List<int> getNewRk(List<num> eq) {
  List<int> newRk = [];
  for (num value in eq) {
    newRk.add(value.toInt());
  }
  return newRk;
}

/// Converts a histogram Map into a List of gray luminance values and their quantity in an image.
/// If `histogramList[34] = 345`, that means there are 345 pixels with luminance value 34 in an image.
///
/// Parameters:
/// - `generatedHistogram`: image's histogram Map.
///
/// Returns:
/// - `histogramList`: image's histogram List.
List<num> histogramListFromMap(Map<int, num> generatedHistogram) {
  List<num> histogramList = [];

  for (int grayLevel = 0; grayLevel < graysQuantity; grayLevel++) {
    histogramList.add(generatedHistogram.containsKey(grayLevel)
        ? generatedHistogram[grayLevel]!
        : 0);
  }

  return histogramList;
}

/// Applies Histogram Equalization to an image by processing
/// each pixel's luminance value in the `originalImageLuminanceList`,
/// and then equalizes these values.
///
/// Parameters:
/// - `originalImageLuminanceList`: List of input image's luminance values.
///
/// Returns:
/// - `histogramList`: a `HistogramResult` containing the equalized histogram and the new equalized image.
HistogramResult histogramEqualization(Uint8List originalImageLuminanceList) {
  Map<int, num> imageHistogram =
      histogramGeneration(originalImageLuminanceList).get<Map<int, num>>()!;
  List<num> nk = histogramListFromMap(imageHistogram);

  List<num> prRk = getPrRk(nk);
  List<num> frequency = getFrequency(prRk);
  List<num> eq = getEq(frequency);
  List<num> newRk = getNewRk(eq);

  List<int> newImageLuminanceList = [];
  for (int pixelValue in originalImageLuminanceList) {
    newImageLuminanceList.add(newRk[pixelValue].toInt());
  }

  Map<int, num> newHistogram =
      histogramGeneration(Uint8List.fromList(newImageLuminanceList))
          .get<Map<int, num>>()!;

  return Tuple(newHistogram, Uint8List.fromList(newImageLuminanceList));
}
