import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ImageInterface {
  const ImageInterface(this._data, this._widget, this._message);

  final ValueNotifier<Uint8List?> _data;
  final Image? _widget;
  final String? _message;

  Image? get widget => _widget;

  Uint8List? get data => _data.value;
  set data(Uint8List? value) => _data.value = value;

  String? get message => _message;
}

class _ImageHook extends Hook<ImageInterface> {
  const _ImageHook(this._data);
  final ValueNotifier<Uint8List?> _data;

  @override
  __ImageHookState createState() => __ImageHookState();
}

class __ImageHookState extends HookState<ImageInterface, _ImageHook> {
  @override
  ImageInterface build(BuildContext context) {
    return ImageInterface(
      hook._data,
      hook._data.value == null || (hook._data.value?.isEmpty ?? false)
          ? null
          : Image.memory(hook._data.value!),
      hook._data.value == null
          ? 'SEM IMAGEM\nPARA MOSTRAR'
          : hook._data.value!.isEmpty
              ? 'IMAGENS TÊM\nTAMANHOS\nDIFERENTES'
              : null,
    );
  }
}

ImageInterface useImage() {
  return use(_ImageHook(useState<Uint8List?>(null)));
}
