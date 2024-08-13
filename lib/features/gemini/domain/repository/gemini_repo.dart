import 'package:flutter_gemini/flutter_gemini.dart';

abstract class GeminiRepo {
  Stream<Candidates> generateAnswer(String text);
}
