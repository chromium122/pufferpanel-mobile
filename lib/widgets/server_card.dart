import 'package:flutter/material.dart';
import 'package:pufferpanel/api/models/server.dart';
import 'package:pufferpanel/pages/server/server_home_page.dart';

class ServerCard extends StatelessWidget {
  final Server server;
  final bool isActive;

  const ServerCard({super.key, required this.server, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ServerHomePage(server: server)));
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Center(
                  child: isActive
                      ? const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(server.name, style: const TextStyle(fontSize: 16)),
                    Text(
                      "${server.ip}:${server.port} @ ${server.node.name}",
                      style: TextStyle(color: Theme.of(context).hintColor),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
