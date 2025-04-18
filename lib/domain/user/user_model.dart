// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String username;
  final String email;
  final String password;
  final String profilePicName;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    required this.profilePicName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'profilePicName': profilePicName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      profilePicName: map['profilePicName'] as String,
    );
  }

  UserModel copyWith({
    String? username,
    String? email,
    String? password,
    String? profilePicName,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      profilePicName: profilePicName ?? this.profilePicName,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, password: $password, profilePicName: $profilePicName)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.username == username &&
      other.email == email &&
      other.password == password &&
      other.profilePicName == profilePicName;
  }

  @override
  int get hashCode {
    return username.hashCode ^
      email.hashCode ^
      password.hashCode ^
      profilePicName.hashCode;
  }
}
