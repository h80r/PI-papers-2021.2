import 'package:pi_papers_2021_2/algorithm/spatial_functions.dart';

enum SpatialFilters {
  laplacian,
  gaussianLaplacian,
  unsharpMasking,
  highboostFiltering,
  gradient,
  robertsSobel,
}

extension Conversors on SpatialFilters {
  static const _stringMap = {
    SpatialFilters.laplacian: 'Laplaciano',
    SpatialFilters.gaussianLaplacian: 'Laplaciano do Gaussiano',
    SpatialFilters.unsharpMasking: 'Unsharp Masking',
    SpatialFilters.highboostFiltering: 'Highboost Filtering',
    SpatialFilters.gradient: 'Gradiente',
    SpatialFilters.robertsSobel: 'Detector de Roberts/Sobel',
  };

  String asText() => _stringMap[this] ?? _stringMap.values.first;

  // TODO: Replace missing filters
  static const _functionMap = {
    SpatialFilters.laplacian: laplaceFilter,
    SpatialFilters.gaussianLaplacian: gaussianFilter,
    SpatialFilters.unsharpMasking: unsharpMaskingFilter,
    SpatialFilters.highboostFiltering: laplaceFilter,
    SpatialFilters.gradient: laplaceFilter,
    SpatialFilters.robertsSobel: robertsSobelFilter,
  };

  SpatialFilter asOperation() =>
      _functionMap[this] ?? _functionMap.values.first;
}

enum DetectorOptions {
  roberts,
  sobel,
}

extension Types on DetectorOptions {
  static const _stringMap = {
    DetectorOptions.roberts: 'Roberts',
    DetectorOptions.sobel: 'Sobel',
  };

  String asText() => _stringMap[this] ?? _stringMap.values.first;

  DetectorOptions change() => this == DetectorOptions.roberts
      ? DetectorOptions.sobel
      : DetectorOptions.roberts;
}
