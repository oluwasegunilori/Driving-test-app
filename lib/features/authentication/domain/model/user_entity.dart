import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class User extends Equatable {
  final String id;
  final String? name;
  final String? email;

  const User({required this.id, this.name, this.email});

  factory User.noSignIn() {
    return User(id: const Uuid().v4());
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json["id"], name: json["name"], email: json["email"]);
  }

  @override
  List<Object?> get props => [id, name, email];
}
