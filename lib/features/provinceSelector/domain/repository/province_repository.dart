import 'package:dri_learn/core/errors/errors.dart';
import 'package:dri_learn/features/provinceSelector/domain/model/province_model.dart';
import 'package:either_dart/either.dart';

abstract class ProvinceRepository {
  ///Or get states whichever is applicable
  ///There are plans to do this for other countries
  Future<Either<MessageException, List<Province>>> getProvinces();
}
