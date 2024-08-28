import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ontario_g1_test_2024/core/data/remote/remote_data_source.dart';

class RemoteDataSourceImpl extends RemoteDataSource {
  final FirebaseFirestore db;

  RemoteDataSourceImpl({required this.db});

  @override
  FirebaseFirestore get fDb => db;
}
