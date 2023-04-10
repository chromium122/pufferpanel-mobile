import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pufferpanel/api/models/error.dart';
import 'package:pufferpanel/api/models/server.dart';
import 'package:pufferpanel/api/models/user.dart';

class PufferPanelClient {
  PufferPanelClient();

  final Dio _dio = Dio();
  String? _accessToken;

  void init(String instance) {
    _dio.options.baseUrl = instance;
  }

  void setToken(String accessToken) {
    _accessToken = accessToken;
    _dio.options.headers['Authentication'] = "Bearer $_accessToken";
    _dio.options.headers['Cookie'] = "puffer_auth=$_accessToken";
  }

  Error _handleError(DioError error) {
    if (error.response?.data["error"] != null) {
      return PufferError(
        code: error.response?.data["error"]["code"],
        msg: error.response?.data["error"]["msg"],
        error: error,
      );
    } else {
      if (kDebugMode) {
        print("ERR: $error");
      }
      return Error();
    }
  }

  Future<String> login(String email, String password) async {
    try {
      Map<String, String> data = {'email': email, 'password': password};
      var response = await _dio.post("/auth/login", data: data);
      assert(response.data["session"] != null);

      return response.data["session"];
    } on DioError catch (error) {
      throw _handleError(error);
    } on AssertionError {
      rethrow;
    }
  }

  Future<User> getUser() async {
    try {
      var resp = await _dio.get("/api/self");

      return User.fromMap(resp.data);
    } on DioError catch (error) {
      throw _handleError(error);
    }
  }

  Future<List<Server>> getServers() async {
    try {
      List<Server> servers = [];
      var resp = await _dio.get("/api/servers");

      for (Map server in resp.data['servers']) {
        servers.add(Server.fromMap(server));
      }

      return servers;
    } on DioError catch (error) {
      throw _handleError(error);
    }
  }

  Future<bool> getServerStatus(String serverId) async {
    try {
      var resp = await _dio.get("/proxy/daemon/server/$serverId/status");

      return resp.data["running"];
    } on DioError catch (error) {
      throw _handleError(error);
    }
  }
}

class PufferPanelClientState extends ChangeNotifier {
  final PufferPanelClient _client = PufferPanelClient();
  PufferPanelClient get client => _client;
}
