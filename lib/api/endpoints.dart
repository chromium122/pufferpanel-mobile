class PufferPanel {
  static String nodes(String instance) => "$instance/node";
  static String node(String instance, int id) => "$instance/node/$id";
  static String nodeDeployment(String instance, int id) =>
      "$instance/node/$id/deployment";
}
