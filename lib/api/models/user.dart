class User {
  final String email;
  final int id;
  final String? password;
  final String username;
  final String? accessToken;

  User({
    required this.email,
    required this.id,
    this.password,
    required this.username,
    this.accessToken,
  });

  factory User.fromMap(Map userMap) {
    return User(
      email: userMap["email"],
      id: userMap["id"],
      username: userMap["username"],
    );
  }
}
