import 'package:dymogo/constants.dart';
import 'package:jwt_decode/jwt_decode.dart';

class AuthProtect {
  static Future isTokenValid() async {
    var token = await storage.read(key: "token");
    print(token);

    if (token != null) {
      var now = new DateTime.now();
      DateTime? expiryDate = Jwt.getExpiryDate(token.toString());
      if (expiryDate != null && expiryDate.isAfter(now)) {
        await storage.delete(key: "token");
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }
}
