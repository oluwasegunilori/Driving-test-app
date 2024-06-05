import 'package:equatable/equatable.dart';

class Province extends Equatable {
  final String name;
  final String country;

  const Province({required this.name, this.country = "Canada"});

  @override
  List<Object?> get props => [name, country];
}
