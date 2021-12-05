import 'dart:typed_data';

/// Converts a 1D list of pixels into a 2D matrix
/// that follows an image's shape.
///
/// Parameters:
/// - `imageLuminanceList`: 1D list of image's luminance values;
/// - `imageWidth`: image's width.
///
/// Returns:
/// - `imageMatrix`: 2D matrix of image's luminance values.
List convertListToMatrix(
  Uint8List imageLuminanceList,
  int imageWidth,
) {
  int imageHeight = imageLuminanceList.length ~/ imageWidth;
  List imageMatrix = [];
  for (var i = 0; i < imageHeight; i++) {
    imageMatrix.add(
      imageLuminanceList.sublist(
        imageWidth * i,
        imageWidth * (i + 1),
      ),
    );
  }
  return imageMatrix;
}
