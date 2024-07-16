enum TestType {
  Sign("Sign"),
  Knowledge("Knowledge"),
  MockTest("MockTest");

  final String value;

  const TestType(this.value);

  static TestType fromString(String value) {
    return TestType.values.firstWhere(
      (enumValue) => enumValue.value == value,
      orElse: () => throw ArgumentError('Invalid enum value: $value'),
    );
  }

  String toJson() => value;
}
