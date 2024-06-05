import 'package:dri_learn/core/data/remote/remote_data_source.dart';
import 'package:dri_learn/core/errors/errors.dart';

import 'package:dri_learn/features/provinceSelector/domain/model/province_model.dart';

import 'package:either_dart/src/either.dart';

import '../../domain/repository/province_repository.dart';
import '../model/province_dto.dart';

const String ProvinceColl = "Canada-Ontario";

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
