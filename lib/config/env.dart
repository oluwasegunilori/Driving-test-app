import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: '.env') //Path of your secret.env file
abstract class Env {
  @EnviedField(varName: 'GEMINI_API_KEY', obfuscate: true)
  static final String geminiAPIKEY = _Env.geminiAPIKEY;
}
