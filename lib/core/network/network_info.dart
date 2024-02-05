import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected => InternetConnection().hasInternetAccess;
}
