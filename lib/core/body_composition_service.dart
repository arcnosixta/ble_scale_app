import 'dart:math';
import 'user_profile.dart';
import 'calibration_model.dart';

class BodyCompositionResult {
  final double bmi;
  final double bodyFat;
  final double fatMass;
  final double ffm;
  final double muscle;
  final double water;
  final double protein;
  final double visceralFat;

  BodyCompositionResult({
    required this.bmi,
    required this.bodyFat,
    required this.fatMass,
    required this.ffm,
    required this.muscle,
    required this.water,
    required this.protein,
    required this.visceralFat,
  });
}

class BodyCompositionService {
  static BodyCompositionResult calculate({
    required double weight,
    required UserProfile user,
    required CalibrationModel calibration,
  }) {
    if (weight <= 0 || user.height <= 0) {
      return BodyCompositionResult(
        bmi: 0, bodyFat: 0, fatMass: 0, ffm: 0, 
        muscle: 0, water: 0, protein: 0, visceralFat: 0
      );
    }

    // 1. BMI
    double bmi = weight / pow(user.height / 100, 2);

    // 2. Body Fat (BF)
    // Formula: 1.2 * bmi + 0.23 * age - genderOffset
    double bodyFat = (1.2 * bmi) + (0.23 * user.age) - user.genderOffset;
    bodyFat += calibration.bfOffset;
    bodyFat = bodyFat.clamp(5.0, 50.0);

    // 3. Derived Metrics
    double fatMass = weight * (bodyFat / 100);
    double ffm = weight - fatMass;

    // Based on typical FFM ratios
    double muscle = (ffm * 0.75 / weight * 100) * calibration.muscleScale;
    double water = (ffm * 0.72 / weight * 100) * calibration.waterScale;
    double protein = ffm * 0.18 / weight * 100;
    double visceralFat = (bodyFat / 4).clamp(1.0, 20.0);

    return BodyCompositionResult(
      bmi: bmi,
      bodyFat: bodyFat,
      fatMass: fatMass,
      ffm: ffm,
      muscle: muscle,
      water: water,
      protein: protein,
      visceralFat: visceralFat,
    );
  }
}
