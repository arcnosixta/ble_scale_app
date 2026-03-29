enum Gender { male, female }

class UserProfile {
  final double height;
  final int age;
  final Gender gender;

  UserProfile({
    required this.height,
    required this.age,
    required this.gender,
  });

  double get genderOffset => gender == Gender.male ? 16.2 : 5.4;
}
