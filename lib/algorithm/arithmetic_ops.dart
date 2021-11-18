import 'dart:typed_data';
import 'package:image/image.dart';

Uint8List sum(
    Uint8List pixelsImgA, Uint8List pixelsImgB, int resultImageLength) {
  Uint8List resultImagePixels = Uint8List(resultImageLength);
  int sum = 0;

  for (var i = 0; i < resultImageLength; i++) {
    sum = pixelsImgA[i] + pixelsImgB[i];
    resultImagePixels[i] = sum < 256 ? sum : 255;
  }
  return resultImagePixels;
}

Uint8List subtraction(
    Uint8List pixelsImgA, Uint8List pixelsImgB, int resultImageLength) {
  Uint8List resultImagePixels = Uint8List(resultImageLength);
  int sub = 0;

  for (var i = 0; i < resultImageLength; i++) {
    sub = pixelsImgA[i] - pixelsImgB[i];
    resultImagePixels[i] = sub > 0 ? sub : 0;
  }
  return resultImagePixels;
}

Uint8List multiplication(
    Uint8List pixelsImgA, Uint8List pixelsImgB, int resultImageLength) {
  Uint8List resultImagePixels = Uint8List(resultImageLength);
  int mult = 0;

  for (var i = 0; i < resultImageLength; i++) {
    mult = pixelsImgA[i] * pixelsImgB[i];
    resultImagePixels[i] = mult < 256 ? mult : 255;
  }
  return resultImagePixels;
}

Uint8List division(
    Uint8List pixelsImgA, Uint8List pixelsImgB, int resultImageLength) {
  Uint8List resultImagePixels = Uint8List(resultImageLength);
  int div = 0;

  for (var i = 0; i < resultImageLength; i++) {
    div = pixelsImgA[i] ~/ pixelsImgB[i];
    resultImagePixels[i] = div > 0 ? div : 0;
  }
  return resultImagePixels;
}
