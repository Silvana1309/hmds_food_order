class UserModel {
  final int? id;
  final String username;
  final String password;
  final String name;
  final String email;

  UserModel({
    this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'name': name,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      name: map['name'],
      email: map['email'],
    );
  }
}
