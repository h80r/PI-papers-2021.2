import 'dart:typed_data';
import 'package:image/image.dart';

/// Adds two images by summing luminance value pixel by pixel and clamping the result to the [0, 255] range.
///
/// Parameters:
/// - `pixelsImgA`: List with luminance value of each pixel in imageA;
/// - `pixelsImgB`: List with luminance value of each pixel in imageB;
/// - `resultImageLength`: int defining the result image's size.
///
/// Returns:
/// - `resultImagePixels`: List with luminance values resulted from sum of each luminance value in `pixelsImgA` and `pixelsImgB`.
Uint8List sum(
  Uint8List pixelsImgA,
  Uint8List pixelsImgB,
  int resultImageLength,
) {
  Uint8List resultImagePixels = Uint8List(resultImageLength);
  int sum;

  for (var i = 0; i < resultImageLength; i++) {
    sum = pixelsImgA[i] + pixelsImgB[i];
    resultImagePixels[i] = sum.clamp(0, 255);
  }

  return resultImagePixels;
}

/// Subtracts two images by subtracting luminance value pixel by pixel and getting its absolute value.
///
/// Parameters:
/// - `pixelsImgA`: List with luminance value of each pixel in imageA;
/// - `pixelsImgB`: List with luminance value of each pixel in imageB;
/// - `resultImageLength`: int defining the result image's size.
///
/// Returns:
/// - `resultImagePixels`: List with luminance values resulted from absolute subtraction of each luminance value in `pixelsImgA` and `pixelsImgB`.
Uint8List subtraction(
  Uint8List pixelsImgA,
  Uint8List pixelsImgB,
  int resultImageLength,
) {
  Uint8List resultImagePixels = Uint8List(resultImageLength);
  int sub;

  for (var i = 0; i < resultImageLength; i++) {
    sub = pixelsImgA[i] - pixelsImgB[i];
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
/// - `resultImageLength`: int defining the result image's size.
///
/// Returns:
/// - `resultImagePixels`: List with luminance values resulted from multiplication of each luminance value in `pixelsImgA` and `pixelsImgB`.
Uint8List multiplication(
  Uint8List pixelsImgA,
  Uint8List pixelsImgB,
  int resultImageLength,
) {
  Uint8List resultImagePixels = Uint8List(resultImageLength);
  double mult;

  for (var i = 0; i < resultImageLength; i++) {
    mult = (pixelsImgA[i] / 255) * (pixelsImgB[i] / 255);
    resultImagePixels[i] = (mult * 255).toInt();
  }
  return resultImagePixels;
}

/// Divides two images by dividing luminance value pixel by pixel.
///
/// Luminance values are divided by 255 before division
/// (range from value 0 representing luminance 0 to value 1 representing luminance 255).
/// After division, the result is multiplied back by 255, recovering the equivalent luminance.
///
/// Parameters:
/// - `pixelsImgA`: List with luminance value of each pixel in imageA;
/// - `pixelsImgB`: List with luminance value of each pixel in imageB;
/// - `resultImageLength`: int defining the result image's size.
///
/// Returns:
/// - `resultImagePixels`: List with luminance values resulted from division of each luminance value in `pixelsImgA` and `pixelsImgB`.
Uint8List division(
  Uint8List pixelsImgA,
  Uint8List pixelsImgB,
  int resultImageLength,
) {
  Uint8List resultImagePixels = Uint8List(resultImageLength);
  double div;

  for (var i = 0; i < resultImageLength; i++) {
    div = (pixelsImgA[i] / 255) / (pixelsImgB[i] / 255);
    resultImagePixels[i] = (div * 255).toInt();
  }
  return resultImagePixels;
}

/// Operates two images regarding the chosen operation.
///
/// Parameters:
/// - `imageA`: List of imageA's bytes;
/// - `imageB`: List of imageB's bytes;
/// - `operation`: Operation function to be executed.
///
/// Returns:
/// - List of result image's bytes.
Uint8List operate(Uint8List imageA, Uint8List imageB, dynamic operation) {
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

  Image imgA = decodeImage(imageA)!;
  Image imgB = decodeImage(imageB)!;

  Uint8List pixelsImgA = imgA.getBytes(format: Format.luminance);
  Uint8List pixelsImgB = imgB.getBytes(format: Format.luminance);

  int resultImageLength = pixelsImgA.length <= pixelsImgB.length
      ? pixelsImgA.length
      : pixelsImgB.length;

  final smallestImg = pixelsImgA.length <= pixelsImgB.length ? imgA : imgB;
  final measurements = {
    'width': smallestImg.width,
    'height': smallestImg.height,
  };

  return reformat(
      measurements,
      operation(
        pixelsImgA,
        pixelsImgB,
        resultImageLength,
      ));
}
