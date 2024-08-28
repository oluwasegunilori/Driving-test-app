import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ontario_g1_test_2024/features/provinceSelector/domain/model/province_model.dart';
import 'package:equatable/equatable.dart';

class ProvinceDto extends Equatable {
  final String country;
  final String name;

  const ProvinceDto({
    required this.name,
    required this.country,
  });

  // Factory constructor to create a Province from a document snapshot
  factory ProvinceDto.fromDocumentSnapshot(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ProvinceDto(
      country: data['country'] ?? '',
      name: data['name'] ?? '',
    );
  }

  Province toDomain() {
    return Province(name: name, country: country);
  }

  @override
  List<Object?> get props => [name, country];
}
