class Node {
  int id;
  bool isLocal;
  String name;
  String? privateHost;
  int? privatePort;
  String publicHost;
  int publicPort;
  int sftpPort;

  Node({
    required this.id,
    required this.isLocal,
    required this.name,
    this.privateHost,
    this.privatePort,
    required this.publicHost,
    required this.publicPort,
    required this.sftpPort,
  });

  factory Node.fromMap(Map nodeMap) {
    return Node(
      id: nodeMap["id"],
      isLocal: nodeMap["isLocal"],
      name: nodeMap["name"],
      privateHost: nodeMap["privateHost"],
      publicHost: nodeMap["publicHost"],
      privatePort: nodeMap["privatePort"],
      publicPort: nodeMap["publicPort"],
      sftpPort: nodeMap["sftpPort"],
    );
  }
}
