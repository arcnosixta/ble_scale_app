class CalibrationModel {
  final double bfOffset;
  final double muscleScale;
  final double waterScale;

  CalibrationModel({
    this.bfOffset = 0.0,
    this.muscleScale = 1.0,
    this.waterScale = 1.0,
  });
}
