import 'dart:math';
import 'dart:typed_data';

import 'package:image/image.dart';

/// Redistributes values in a list using [0, 1] scale back to the [0, 255] luminance range.
///
/// Parameters:
/// - `results`: List with results from luminance values divided pixel by pixel.
///
/// Returns:
/// - `resultImagePixels`: List with luminance values in `results` redistributes to [0, 255] luminance range.
/// If all luminance values are equal, a zero list is returned.
Uint8List normalize(List<num> results) {
  final resultImagePixels = Uint8List(results.length);

  final minNumber = results.reduce(min);
  final maxNumber = results.reduce(max);
  final denominator = maxNumber - minNumber;

  if (minNumber != maxNumber) {
    for (var i = 0; i < results.length; i++) {
      resultImagePixels[i] =
          (((results[i] - minNumber) / denominator) * 255).toInt();
    }
    return resultImagePixels;
  } else {
    return resultImagePixels;
  }
}

/// Adds two images by summing luminance value pixel by pixel and clamping the result to the [0, 255] range.
///
/// Parameters:
/// - `pixelsImgA`: List with luminance value of each pixel in imageA;
/// - `pixelsImgB`: List with luminance value of each pixel in imageB;
///
/// Returns:
/// - `resultImagePixels`: List with luminance values resulted from sum of each luminance value in `pixelsImgA` and `pixelsImgB`.
Uint8List sum(
  Uint8List pixelsImgA,
  Uint8List pixelsImgB,
) {
  final resultImagePixels = Uint8List(pixelsImgA.length);

  for (var i = 0; i < pixelsImgA.length; i++) {
    final sum = pixelsImgA[i] + pixelsImgB[i];
    resultImagePixels[i] = sum.clamp(0, 255);
  }

  return resultImagePixels;
}

/// Subtracts two images by subtracting luminance value pixel by pixel and getting its absolute value.
///
/// Parameters:
/// - `pixelsImgA`: List with luminance value of each pixel in imageA;
/// - `pixelsImgB`: List with luminance value of each pixel in imageB;
///
/// Returns:
/// - `resultImagePixels`: List with luminance values resulted from absolute subtraction of each luminance value in `pixelsImgA` and `pixelsImgB`.
Uint8List subtraction(
  Uint8List pixelsImgA,
  Uint8List pixelsImgB,
) {
  final resultImagePixels = Uint8List(pixelsImgA.length);

  for (var i = 0; i < pixelsImgA.length; i++) {
    final sub = pixelsImgA[i] - pixelsImgB[i];
    resultImagePixels[i] = sub.abs();
  }
  return resultImagePixels;
}

/// Multiplies two images by multiplying luminance value pixel by pixel.
///
/// Luminance values are divided by 255 before multiplication
/// (range from value 0 representing luminance 0 to value 1 representing luminance 255).
/// After multiplication, the result is multiplied back by 255, recovering the equivalent luminance.
///
/// Parameters:
/// - `pixelsImgA`: List with luminance value of each pixel in imageA;
/// - `pixelsImgB`: List with luminance value of each pixel in imageB;
///
/// Returns:
/// - `resultImagePixels`: List with luminance values resulted from multiplication of each luminance value in `pixelsImgA` and `pixelsImgB`.
Uint8List multiplication(
  Uint8List pixelsImgA,
  Uint8List pixelsImgB,
) {
  final resultImagePixels = Uint8List(pixelsImgA.length);

  for (var i = 0; i < pixelsImgA.length; i++) {
    final mult = (pixelsImgA[i] / 255) * (pixelsImgB[i] / 255);
    resultImagePixels[i] = (mult * 255).toInt();
  }
  return resultImagePixels;
}

/// Divides two images by dividing luminance value pixel by pixel.
///
/// Luminance values in `pixelsImgA` are divided by luminance values in `pixelsImgB` one by one.
/// If a pixel in `pixelsImgB` is 0, the division takes 1 as the denominator.
///
/// Because the results are very close numbers, to improve the result image's colors, a Min-Max normalization
/// is made to better redistribute the values in the [0, 255] luminance range.
///
/// Parameters:
/// - `pixelsImgA`: List with luminance value of each pixel in imageA;
/// - `pixelsImgB`: List with luminance value of each pixel in imageB;
///
/// Returns:
/// - List with luminance values resulted from division
/// of each luminance value in `pixelsImgA` by `pixelsImgB`.
/// If all luminance values are equal, a zero list is returned.
Uint8List division(
  Uint8List pixelsImgA,
  Uint8List pixelsImgB,
) {
  final results = <num>[];

  for (var i = 0; i < pixelsImgA.length; i++) {
    results.add(pixelsImgB[i] != 0
        ? (pixelsImgA[i] / pixelsImgB[i])
        : (pixelsImgA[i] / 1));
  }

  return normalize(results);
}

/// Operates two images regarding the chosen operation.
///
/// Parameters:
/// - `imageA`: List of imageA's bytes;
/// - `imageB`: List of imageB's bytes;
/// - `operation`: Operation function to be executed.
///
/// Returns:
/// - List of result image's bytes if `imageA` and `imageB` are the same size, empty list otherwise.
Uint8List? operate(
  Uint8List? imageA,
  Uint8List? imageB,
  Uint8List Function(Uint8List, Uint8List)? operation,
) {
  Uint8List reformat(Map<String, int> measurements, Uint8List processedImage) {
    return Uint8List.fromList(
      encodePng(
        Image.fromBytes(
          measurements['width'] ?? 0,
          measurements['height'] ?? 0,
          processedImage,
          format: Format.luminance,
        ),
      ),
    );
  }

  if (imageA == null || imageB == null || operation == null) return null;

  final imgA = decodeImage(imageA)!;
  final imgB = decodeImage(imageB)!;

  final pixelsImgA = imgA.getBytes(format: Format.luminance);
  final pixelsImgB = imgB.getBytes(format: Format.luminance);

  if (pixelsImgA.length != pixelsImgB.length) {
    return Uint8List(0);
  }

  final measurements = {
    'width': imgA.width,
    'height': imgA.height,
  };

  return reformat(
      measurements,
      operation(
        pixelsImgA,
        pixelsImgB,
      ));
}
