import 'package:dri_learn/features/provinceSelector/domain/repository/province_repository.dart';
import 'package:dri_learn/features/provinceSelector/presentation/province_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'province_event.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  final ProvinceRepository repository;

  ProvinceBloc(this.repository) : super(InitialState());

  @override
  void onEvent(ProvinceEvent event) {
    super.onEvent(event);
  }
}
