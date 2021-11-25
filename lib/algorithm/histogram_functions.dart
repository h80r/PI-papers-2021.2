Function() getOperation(dropdownCurrentValue) {
  switch (dropdownCurrentValue) {
    case 'Histograma':
      return getHistogram;
    case 'Histograma normalizado':
      return getNormalizedHistogram;
    case 'Equalização de histograma':
      return histogramEqualization;
    default:
      return contrastStreching;
  }
}

Map<int, num> getIntensityFrequency(pixelsLuminanceValues) {
  final intensityFrequency = <int, num>{};
  for (final v in pixelsLuminanceValues) {
    intensityFrequency.update(v, (value) => value + 1, ifAbsent: () => 1);
  }
  return intensityFrequency;
}

void getHistogram() {}

void getNormalizedHistogram() {}

void enhancement() {}

void histogramEqualization() {}

void contrastStreching() {}
