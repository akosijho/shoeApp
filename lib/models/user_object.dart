import 'package:equatable/equatable.dart';

class User extends Equatable {
  String name;
  String? id;
  String? avatar;
  String? email;
  String? password;

  User(
      {required this.name,
      this.id,
      this.avatar,
      required this.email,
      this.password});

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'avatar': avatar,
        'email': email,
        'password': password
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json["name"] as String,
      id: json["id"] as String?,
      avatar: json["avatar"] as String?,
      email: json["email"] as String?);

  @override
  // TODO: implement props
  List<Object?> get props => [name, id, avatar, email];
}
