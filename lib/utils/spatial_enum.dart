enum SpatialFilters {
  laplacian,
  sharpening,
  gaussianLaplacian,
  unsharpMasking,
  highboostFiltering,
  gradient,
  robertsSobel,
}

extension Stringify on SpatialFilters {
  static const _map = {
    SpatialFilters.laplacian: 'Laplaciano',
    SpatialFilters.sharpening: 'Sharpening',
    SpatialFilters.gaussianLaplacian: 'Laplaciano do Gaussiano',
    SpatialFilters.unsharpMasking: 'Unsharp Masking',
    SpatialFilters.highboostFiltering: 'Highboost Filtering',
    SpatialFilters.gradient: 'Gradiente',
    SpatialFilters.robertsSobel: 'Detector de Roberts/Sobel',
  };

  String get text => _map[this] ?? _map.values.first;
}
