import 'package:flutter_gemini/flutter_gemini.dart';

abstract class GeminiRepo {
  Future<Candidates?> generateAnswer(String text);
}
