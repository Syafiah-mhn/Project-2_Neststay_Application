class User {
  final String id;
  final String username;
  final String name;
  final String email;
  final String? password; // Make password nullable

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    this.password, // Nullable parameter
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'], // Can be null
    );
  }
}
