class UserModel {
  int? id;
  String username;
  String password;
  String name;
  String email;
  String? profileImage;
  String role;

  UserModel({
    this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.email,
    this.profileImage,
    this.role = "user",
  });



  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      name: map['name'],
      email: map['email'],
      profileImage: map['profile_image'], // ✅ FIXED
      role: map['role'] ?? "user",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'name': name,
      'email': email,
      'profile_image': profileImage, // ✅ FIXED
      'role': role,
    };
  }
}
