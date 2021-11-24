import 'dart:typed_data';

import 'package:image/image.dart';

/// Formats the [processedImage] to a [Uint8List] readable by Image widgets.
///
/// Parameters:
/// - `width`: The width of the image.
/// - `height`: The height of the image.
/// - `processedImage`: The image to be formatted.
/// - `format`: The desired format of the image.
///
/// Returns:
/// - An [Uint8List] with the image data.
Uint8List reformat({
  required int width,
  required int height,
  required Uint8List processedImage,
  Format format = Format.rgba,
}) {
  return Uint8List.fromList(
    encodePng(Image.fromBytes(width, height, processedImage, format: format)),
  );
}
