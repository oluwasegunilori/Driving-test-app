import 'dart:convert';
import 'dart:ffi';
import 'package:dri_learn/features/tests/core/domain/model/test_type.dart';
import 'package:floor/floor.dart';

class StringListConverter extends TypeConverter<List<String>, String> {
  @override
  List<String> decode(String databaseValue) {
    return (jsonDecode(databaseValue) as List).map((e) => e as String).toList();
  }

  @override
  String encode(List<String> value) {
    return jsonEncode(value);
  }
}

class TestTypeConverter extends TypeConverter<TestType, String> {
  @override
  TestType decode(String databaseValue) {
    return TestType.fromString(databaseValue);
  }

  @override
  String encode(TestType value) {
    return value.value;
  }
}
