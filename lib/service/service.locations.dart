import 'package:grpc/grpc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:togg_case/gprc_flutter_client.dart';
import 'package:togg_case/service/poi.pbgrpc.dart';

class LocationService {
  static Future<dynamic> getPois() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    String? token = shared.getString("token");

    PoiLocatorClient client = PoiLocatorClient(GrpcClientSingleton().client);
    PoiRequest poiRequest = PoiRequest.create();
    return client.getPois(
      poiRequest,
      options: CallOptions(metadata: {
        'Authorization': 'Bearer $token',
      }),
    );
  }
}
