import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pufferpanel/api/client.dart';
import 'package:pufferpanel/api/models/error.dart';
import 'package:pufferpanel/api/websocket_client.dart';
import 'package:pufferpanel/providers/user_provider.dart';
import 'package:pufferpanel/utils/show_error.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController instanceController =
      TextEditingController(text: "https://mc.chromium.hu");
  late PufferPanelClient client;
  late PufferPanelWebSocketClient webSocketClient;

  @override
  void initState() {
    super.initState();
  }

  void handleLogin(UserProvider userProvider) async {
    client.init(instanceController.text);

    try {
      var session =
          await client.login(emailController.text, passwordController.text);
      client.setToken(session);
      webSocketClient.init(
          accesstoken: session, instance: instanceController.text);

      var user = await client.getUser();
      userProvider.setUser(user);
    } on PufferError catch (error) {
      showError(context, error.msg);
    } on DioError catch (error) {
      if (kDebugMode) {
        print("ERR: $error");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    client = Provider.of<PufferPanelClientState>(context).client;
    webSocketClient =
        Provider.of<PufferPanelWebSocketClientState>(context).client;

    return Scaffold(
      appBar: AppBar(title: const Text("Log In")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                autofillHints: const [
                  AutofillHints.email,
                  AutofillHints.username
                ],
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: passwordController,
                autofillHints: const [AutofillHints.password],
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: instanceController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Instance",
                ),
              ),
              const SizedBox(height: 10),
              Consumer<UserProvider>(builder: (context, userProvider, child) {
                return FilledButton(
                  onPressed: () {
                    handleLogin(userProvider);
                  },
                  child: const Text("Log In"),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
