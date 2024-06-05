import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dri_learn/core/data/remote/remote_data_source.dart';

class RemoteDataSourceImpl extends RemoteDataSource {
  final FirebaseFirestore db;

  RemoteDataSourceImpl({required this.db});
  
  @override
  FirebaseFirestore get fDb => db;
}
