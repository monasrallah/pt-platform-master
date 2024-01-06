
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../../domain/core/utils/network/network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
