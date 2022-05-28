import 'package:togg_case/gprc_flutter_client.dart';
import 'package:togg_case/service/poi.pbgrpc.dart';

class AuthService {
  static Future<LoginReply> login(String username, String password) async {
    AuthenticationClient client =
        AuthenticationClient(GrpcClientSingleton().client);
    LoginRequest request = LoginRequest.create();
    request.username = username;
    request.password = password;
    return await client.login(request);
  }
}
