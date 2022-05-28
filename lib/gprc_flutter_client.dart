import 'package:grpc/grpc.dart';
import 'package:togg_case/const.dart';

class GrpcClientSingleton {
  ClientChannel client = ClientChannel({});
  static final GrpcClientSingleton _singleton = GrpcClientSingleton._internal();
  GrpcClientSingleton._internal() {
    client = ClientChannel(
      Const.hostName,
      port: Const.port,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
        idleTimeout: Duration(minutes: 1),
      ),
    );
  }
  factory GrpcClientSingleton() => _singleton;
}
