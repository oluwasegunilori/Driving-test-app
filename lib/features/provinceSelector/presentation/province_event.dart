import 'package:dri_learn/features/provinceSelector/domain/model/province_model.dart';
import 'package:equatable/equatable.dart';

abstract class ProvinceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SelectProvinceEvent extends ProvinceEvent {
  final Province province;

  SelectProvinceEvent({required this.province});
}

class GetProvinceEvent extends ProvinceEvent {

}
