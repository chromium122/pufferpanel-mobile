import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pufferpanel/api/client.dart';
import 'package:pufferpanel/api/models/server.dart';
import 'package:pufferpanel/api/websocket_client.dart';

import 'package:pufferpanel/pages/home/settings_page.dart';
import 'package:pufferpanel/pages/server/console_page.dart';
import 'package:pufferpanel/pages/server/files_page.dart';
import 'package:pufferpanel/pages/server/statistics_page.dart';

class ServerHomePage extends StatefulWidget {
  final Server server;
  const ServerHomePage({super.key, required this.server});

  @override
  State<ServerHomePage> createState() => _ServerHomePageState();
}

class _ServerHomePageState extends State<ServerHomePage> {
  late PufferPanelWebSocketClient webSocketClient;
  late PufferPanelClient client;
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    webSocketClient =
        Provider.of<PufferPanelWebSocketClientState>(context).client;
    client = Provider.of<PufferPanelClientState>(context).client;

    webSocketClient.connect(widget.server.id);

    List<Widget> destinations = [
      ConsolePage(
        webSocketClient: webSocketClient,
      ),
      StatisticsPage(),
      FilesPage(),
      SettingsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.server.name),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: pageIndex,
        onDestinationSelected: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.terminal_outlined),
            selectedIcon: Icon(Icons.terminal),
            label: "Console",
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart_outlined),
            selectedIcon: Icon(Icons.show_chart),
            label: "Statistics",
          ),
          NavigationDestination(
            icon: Icon(Icons.folder_outlined),
            selectedIcon: Icon(Icons.folder),
            label: "Files",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
      body: destinations[pageIndex],
    );
  }
}
