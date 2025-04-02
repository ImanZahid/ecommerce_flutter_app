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
    return {
      'username': username,
      'email': email,
      'password': password,
      'profilePicName': profilePicName,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'],
      email: map['email'],
      password: map['password'],
      profilePicName: map['profilePicName'],
    );
  }
}
