import 'dart:typed_data';
import 'package:image/image.dart';

Uint8List sum(
  Uint8List pixelsImgA,
  Uint8List pixelsImgB,
  int resultImageLength,
) {
  Uint8List resultImagePixels = Uint8List(resultImageLength);
  int sum = 0;

  for (var i = 0; i < resultImageLength; i++) {
    sum = pixelsImgA[i] + pixelsImgB[i];
    resultImagePixels[i] = sum < 256 ? sum : 255;
  }

  return resultImagePixels;
}

Uint8List subtraction(
  Uint8List pixelsImgA,
  Uint8List pixelsImgB,
  int resultImageLength,
) {
  Uint8List resultImagePixels = Uint8List(resultImageLength);
  int sub = 0;

  for (var i = 0; i < resultImageLength; i++) {
    sub = pixelsImgA[i] - pixelsImgB[i];
    resultImagePixels[i] = sub > 0 ? sub : 0;
  }
  return resultImagePixels;
}

Uint8List multiplication(
  Uint8List pixelsImgA,
  Uint8List pixelsImgB,
  int resultImageLength,
) {
  Uint8List resultImagePixels = Uint8List(resultImageLength);
  int mult = 0;

  for (var i = 0; i < resultImageLength; i++) {
    mult = pixelsImgA[i] * pixelsImgB[i];
    resultImagePixels[i] = mult < 256 ? mult : 255;
  }
  return resultImagePixels;
}

Uint8List division(
  Uint8List pixelsImgA,
  Uint8List pixelsImgB,
  int resultImageLength,
) {
  Uint8List resultImagePixels = Uint8List(resultImageLength);
  int div = 0;

  for (var i = 0; i < resultImageLength; i++) {
    div = pixelsImgA[i] ~/ pixelsImgB[i];
    resultImagePixels[i] = div > 0 ? div : 0;
  }
  return resultImagePixels;
}

Uint8List? operate(Uint8List? imageA, Uint8List? imageB, int operation) {
  Uint8List reformat(Map<String, int> measurements, Uint8List processedImage) {
    return Uint8List.fromList(
      encodePng(
        Image.fromBytes(
          measurements['width'] ?? 0,
          measurements['height'] ?? 0,
          processedImage,
          format: Format.rgb,
        ),
      ),
    );
  }

  Image imgA = decodeImage(imageA!)!;
  Image imgB = decodeImage(imageB!)!;

  Uint8List pixelsImgA = imgA.getBytes(format: Format.rgb);
  Uint8List pixelsImgB = imgB.getBytes(format: Format.rgb);

  int resultImageLength = pixelsImgA.length <= pixelsImgB.length
      ? pixelsImgA.length
      : pixelsImgB.length;

  final smallestImg = pixelsImgA.length <= pixelsImgB.length ? imgA : imgB;
  final measurements = {
    'width': smallestImg.width,
    'height': smallestImg.height,
  };

  if (operation == 1) {
    return reformat(
      measurements,
      sum(pixelsImgA, pixelsImgB, resultImageLength),
    );
  } else if (operation == 2) {
    return subtraction(pixelsImgA, pixelsImgB, resultImageLength);
  } else if (operation == 3) {
    return multiplication(pixelsImgA, pixelsImgB, resultImageLength);
  } else if (operation == 4) {
    return division(pixelsImgA, pixelsImgB, resultImageLength);
  } else {
    return null;
  }
}
