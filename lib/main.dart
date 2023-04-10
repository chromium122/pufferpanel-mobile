import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:provider/provider.dart';
import 'package:pufferpanel/api/client.dart';
import 'package:pufferpanel/api/websocket_client.dart';
import 'package:pufferpanel/pages/home_page.dart';
import 'package:pufferpanel/pages/login_page.dart';
import 'package:pufferpanel/providers/user_provider.dart';

void main() {
  runApp(PufferpanelApp(
    userProvider: UserProvider(),
    pufferPanelClientState: PufferPanelClientState(),
    pufferPanelWebSocketClientState: PufferPanelWebSocketClientState(),
  ));
}

class PufferpanelApp extends StatelessWidget {
  final UserProvider userProvider;
  final PufferPanelClientState pufferPanelClientState;
  final PufferPanelWebSocketClientState pufferPanelWebSocketClientState;
  const PufferpanelApp(
      {super.key,
      required this.userProvider,
      required this.pufferPanelClientState,
      required this.pufferPanelWebSocketClientState});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) FlutterDisplayMode.setHighRefreshRate();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => userProvider),
        ChangeNotifierProvider(create: (_) => pufferPanelClientState),
        ChangeNotifierProvider(create: (_) => pufferPanelWebSocketClientState),
      ],
      child: MaterialApp(
        title: 'PufferPanel',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.cyan, brightness: Brightness.light),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.cyan, brightness: Brightness.dark)),
        home: Consumer<UserProvider>(
          builder: (context, _, child) {
            return userProvider.user != null
                ? const HomePage()
                : const LoginPage();
          },
        ),
      ),
    );
  }
}
