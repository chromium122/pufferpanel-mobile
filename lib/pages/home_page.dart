import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pufferpanel/pages/home/nodes_page.dart';
import 'package:pufferpanel/pages/home/templates_page.dart';

import 'package:pufferpanel/pages/home/servers_page.dart';
import 'package:pufferpanel/pages/home/settings_page.dart';
import 'package:pufferpanel/pages/home/users_page.dart';
import 'package:pufferpanel/providers/user_provider.dart';

const List<Widget> destinations = [
  ServersPage(),
  NodesPage(),
  UsersPage(),
  TemplatesPage(),
  SettingsPage(),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int pageIndex = 0;

  void handleDestinationSelected(int value) {
    scaffoldKey.currentState!.closeDrawer();
    setState(() {
      pageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            return const Text("PufferPanel");
          },
        ),
      ),
      drawer: Drawer(
        child: NavigationDrawer(
          onDestinationSelected: handleDestinationSelected,
          selectedIndex: pageIndex,
          children: const [
            Padding(
              padding: EdgeInsets.fromLTRB(28, 16, 16, 16),
              child: Text("PufferPanel",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            NavigationDrawerDestination(
              icon: Icon(Icons.storage_outlined),
              selectedIcon: Icon(Icons.storage),
              label: Text("Servers"),
            ),
            NavigationDrawerDestination(
              icon: Icon(Icons.cloud_outlined),
              selectedIcon: Icon(Icons.cloud),
              label: Text("Nodes"),
            ),
            NavigationDrawerDestination(
              icon: Icon(Icons.group_outlined),
              selectedIcon: Icon(Icons.group),
              label: Text("Users"),
            ),
            NavigationDrawerDestination(
              icon: Icon(Icons.integration_instructions_outlined),
              selectedIcon: Icon(Icons.integration_instructions),
              label: Text("Templates"),
            ),
            NavigationDrawerDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: Text("Settings"),
            )
          ],
        ),
      ),
      body: destinations[pageIndex],
    );
  }
}
