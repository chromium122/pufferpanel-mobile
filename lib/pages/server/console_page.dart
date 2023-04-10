import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pufferpanel/api/websocket_client.dart';

class ConsolePage extends StatefulWidget {
  final PufferPanelWebSocketClient webSocketClient;
  const ConsolePage({super.key, required this.webSocketClient});

  @override
  State<ConsolePage> createState() => _ConsolePageState();
}

class _ConsolePageState extends State<ConsolePage> {
  List<String> console = [];
  ScrollController scrollController = ScrollController();
  TextEditingController commandController = TextEditingController();

  @override
  void initState() {
    super.initState();

    widget.webSocketClient.channel.stream.listen((message) {
      var data = json.decode(message);
      if (data["type"] == "console") {
        handleConsoleData(data["data"]);
      }
    });
  }

  void handleConsoleData(Map consoleData) {
    for (String log in consoleData["logs"]) {
      setState(() {
        console.add(log);
      });
    }

    scrollController.animateTo(0.0,
        duration: Duration.zero, curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
              child: SingleChildScrollView(
                reverse: true,
                controller: scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SelectableText(
                    console.join(),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: commandController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Command",
            ),
          ),
        ],
      ),
    );
  }
}
