import 'dart:developer';
import 'package:dri_learn/features/gemini/domain/repository/gemini_repo.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiRepoImpl extends GeminiRepo {
  final Gemini gemini;
  GeminiRepoImpl(this.gemini);

  @override
  Stream<Candidates> generateAnswer(String text) {
    return gemini.streamGenerateContent(text);
  }
}
