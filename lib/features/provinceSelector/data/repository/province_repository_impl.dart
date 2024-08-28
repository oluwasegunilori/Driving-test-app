import 'package:ontario_g1_test_2024/core/data/remote/remote_data_source.dart';
import 'package:ontario_g1_test_2024/core/errors/errors.dart';

import 'package:ontario_g1_test_2024/features/provinceSelector/domain/model/province_model.dart';

import 'package:either_dart/src/either.dart';

import '../../domain/repository/province_repository.dart';
import '../model/province_dto.dart';

const String ProvinceColl = "Provinces";

class ProvinceRepositoryImpl extends ProvinceRepository {
  final RemoteDataSource remoteDataSource;

  ProvinceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<MessageException, List<Province>>> getProvinces() {
    return remoteDataSource.fDb.collection(ProvinceColl).get().then((value) =>
        Right(value.docs
            .map((e) => ProvinceDto.fromDocumentSnapshot(e).toDomain())
            .toList()));
  }
}
