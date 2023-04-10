import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pufferpanel/api/client.dart';
import 'package:pufferpanel/api/models/error.dart';
import 'package:pufferpanel/providers/user_provider.dart';

import 'package:pufferpanel/widgets/server_card.dart';
import 'package:pufferpanel/api/models/server.dart';

class ServersPage extends StatefulWidget {
  const ServersPage({super.key});

  @override
  State<ServersPage> createState() => _ServersPageState();
}

class _ServersPageState extends State<ServersPage> {
  List<Server> servers = [];
  Map<String, bool> activeServers = {};
  bool _hasLoaded = false;
  late PufferPanelClient client;

  @override
  void initState() {
    super.initState();
  }

  void loadServers() async {
    List<Server> serverList = await client.getServers();
    setServers(serverList);

    Map<String, bool> activeServerList = {};
    for (Server server in serverList) {
      try {
        bool isActive = await client.getServerStatus(server.id);
        activeServerList[server.id] = isActive;
      } on PufferError catch (error) {
        if (kDebugMode) {
          print("${error.msg} ${server.id}");
        }
      }
    }

    setActiveServers(activeServerList);
  }

  void setServers(List<Server> serverList) {
    setState(() {
      servers = serverList;
      _hasLoaded = true;
    });
  }

  void setActiveServers(Map<String, bool> activeServerList) {
    setState(() {
      activeServers = activeServerList;
    });
  }

  @override
  Widget build(BuildContext context) {
    client = Provider.of<PufferPanelClientState>(context).client;

    if (!_hasLoaded) {
      loadServers();
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Text(
                "Servers",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                    children: servers.map((server) {
                  return ServerCard(
                      server: server,
                      isActive: activeServers[server.id] != null
                          ? activeServers[server.id]!
                          : false);
                }).toList()),
              ),
            ),
          ],
        ),
      );
    }
  }
}
