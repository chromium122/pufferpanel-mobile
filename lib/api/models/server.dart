import 'package:pufferpanel/api/models/node.dart';
import 'package:pufferpanel/api/models/server_user.dart';

class Server {
  String id;
  String ip;
  String name;
  Node node;
  int? nodeId;
  int port;
  String type;
  List<ServerUser>? users;

  Server({
    required this.id,
    required this.ip,
    required this.name,
    required this.node,
    this.nodeId,
    required this.port,
    required this.type,
    this.users,
  });

  factory Server.fromMap(Map serverMap) {
    List<ServerUser> users = [];
    if (serverMap["users"] != null) {
      for (Map userMap in serverMap["users"]) {
        users.add(ServerUser.fromMap(userMap));
      }
    }

    return Server(
      id: serverMap["id"],
      ip: serverMap["ip"],
      name: serverMap["name"],
      node: Node.fromMap(serverMap["node"]),
      nodeId: serverMap["nodeId"],
      port: serverMap["port"],
      type: serverMap["type"],
      users: serverMap["users"],
    );
  }
}
