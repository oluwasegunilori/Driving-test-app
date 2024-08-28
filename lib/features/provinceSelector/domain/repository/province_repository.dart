import 'package:ontario_g1_test_2024/core/errors/errors.dart';
import 'package:ontario_g1_test_2024/features/provinceSelector/domain/model/province_model.dart';
import 'package:either_dart/either.dart';

abstract class ProvinceRepository {
  ///Or get states whichever is applicable
  ///There are plans to do this for other countries
  Future<Either<MessageException, List<Province>>> getProvinces();
}
