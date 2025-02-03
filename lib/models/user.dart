class User {
  final String id;
  final String name;
  final String email;
  final String? bio;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.bio,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      bio: json['bio'],
    );
  }
}