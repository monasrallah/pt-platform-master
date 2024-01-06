double getSuitableBigScale(double systemScale) {
  if (systemScale >= 0.7 && systemScale <= 1.1) {
    return systemScale;
  } else if (systemScale >= 1.2 && systemScale <= 1.4) {
    return systemScale;
  } else if (systemScale == 1.5) {
    return 1.3;
  } else if (systemScale >= 1.6 && systemScale <= 1.7) {
    return 1.3;
  }
  return 1.3;
}

double getSuitableSmaleScale(double systemScale) {
  if (systemScale >= 0.7 && systemScale <= 1) {
    return systemScale;
  }
  return 1.1;
}
