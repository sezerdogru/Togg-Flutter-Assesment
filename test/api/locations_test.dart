import 'package:flutter_test/flutter_test.dart';
import 'package:togg_case/service/poi.pbgrpc.dart';
import 'package:togg_case/service/service.locations.dart';

void main() {
  test("locations api test", () async {
    var locations = await LocationService.getPois();
    List<PoiReply> list = await locations.toList();
    expect(list.isNotEmpty, true);
  });
}
