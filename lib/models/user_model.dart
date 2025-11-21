class UserModel {
  final int? id;
  final String username;
  final String password;
  final String name;
  final String email;
  final String? profileImage; // << TAMBAHKAN INI

  UserModel({
    this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.email,
    this.profileImage, // << DAN INI
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'name': name,
      'email': email,
      'profile_image': profileImage, // << SIMPAN KE DB
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      username: map['username'],
      password: map['password'],
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      profileImage: map['profile_image'], // << AMBIL DARI DB
    );
  }
}
