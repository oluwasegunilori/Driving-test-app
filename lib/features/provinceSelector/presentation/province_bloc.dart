// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:dri_learn/features/provinceSelector/domain/model/province_model.dart';
import 'package:dri_learn/features/provinceSelector/domain/repository/province_repository.dart';
import 'package:dri_learn/features/provinceSelector/presentation/province_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'province_event.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  final ProvinceRepository repository;

  ProvinceBloc(this.repository) : super(const InitialState()) {
    on<GetProvinceEvent>((event, emit) async {
      var response = await repository.getProvinces();
      response.either((er) => null, (data) {
        emit(DoneState(provinces: data, selectedProvinces: const <Province>{}));
      });
    });

    on<SelectProvinceEvent>((event, emit) {
      final DoneState? currentState = (state as DoneState?);
      if (currentState == null) return;

      var selectedProv = Set<Province>.from(currentState.selectedProvinces);
      if (selectedProv.contains(event.province)) {
        selectedProv.remove(event.province);
      } else {
        selectedProv.add(event.province);
      }
      emit(currentState.copyWith(selectedProvinces: selectedProv));
      print(selectedProv);
    });
  }
}
