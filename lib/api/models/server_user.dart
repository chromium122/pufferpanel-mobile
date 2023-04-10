class ServerUser {
  List<String> scopes;
  String username;

  ServerUser({required this.username, required this.scopes});

  factory ServerUser.fromMap(Map serverUserMap) {
    return ServerUser(
      username: serverUserMap["username"],
      scopes: serverUserMap["scopes"],
    );
  }
}
