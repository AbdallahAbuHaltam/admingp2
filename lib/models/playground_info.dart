import 'package:admingp2/models/admin.dart';
import 'package:admingp2/models/facilities.dart';

class PlaygroundInfo {
  Admin? admin;
  String? playgroundName;
  String? size;
  double? price;
  String? type;
  String? payment;
  Facilities? facilities;

  PlaygroundInfo({
    this.admin,
    this.playgroundName,
    this.size,
    this.price,
    this.type,
    this.payment,
    this.facilities,
  });

  Map<String, dynamic> toMap() {
    return {
      'adminName': admin!.adminName,
      'email': admin!.email,
      'phoneNo': admin!.phoneNo,
      'password': admin!.password,
      'adminID': admin!.adminID,
      'waterPrice': facilities!.waterPrice,
      'gatoradePrice': facilities!.gatoradePrice,
      'kit': facilities!.kit,
      'playgroundName': playgroundName,
      'price': price,
      'type': type,
      'size': size,
      'payment': payment,
    };
  }
}
