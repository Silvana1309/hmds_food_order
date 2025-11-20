class UserModel {
  final int? id;
  final String username;
  final String password;
  final String? name;
  final String? email;
  final String? profileImage; // simpan path/URL atau base64

  UserModel({
    this.id,
    required this.username,
    required this.password,
    this.name,
    this.email,
    this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'name': name,
      'email': email,
      'profile_image': profileImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      username: map['username'] as String? ?? '',
      password: map['password'] as String? ?? '',
      name: map['name'] as String?,
      email: map['email'] as String?,
      profileImage: map['profile_image'] as String?,
    );
  }
}