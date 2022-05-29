import 'package:flutter_test/flutter_test.dart';
import 'package:togg_case/service/service.auth.dart';

void main() {
  test("login api test", () async {
    var login = await AuthService.login("Test", "Togg");
    expect(login.hasToken(), true);
  });
}
