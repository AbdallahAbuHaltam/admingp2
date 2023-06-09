import 'package:admingp2/models/admin.dart';
import 'package:admingp2/models/facilities.dart';

class PlaygroundInfo {
  Admin? admin;
  String? playgroundName;
  String? size;
  String? price;
  String? type;
  String? payment;
  Facilities? facilities;
  String? playgroundId;

  PlaygroundInfo({
    this.admin,
    this.playgroundName,
    this.size,
    this.price,
    this.type,
    this.playgroundId,
    this.payment,
    this.facilities,
  });

  PlaygroundInfo.formJson(Map<String, dynamic>? json) {
    admin?.adminName = json?['adminName'];
    admin?.email = json?['email'];
    admin?.phoneNo = json?['phoneNo'];
    admin?.password = json?['password'];
    admin?.adminID = json?['adminID'];
    facilities?.waterPrice = json?['waterPrice'];
    facilities?.gatoradePrice = json?['gatoradePrice'];
    facilities?.kit = json?['kit'];

    playgroundName = json?['playgroundName'];
    price = json?['price'];
    type = json?['type'];
    size = json?['size'];
    payment =json?['payment'];
    playgroundId = json?['playgroundId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'adminName': admin!.adminName,
      'email': admin!.email,
      'phoneNo': admin!.phoneNo,
      'password': admin!.password,
      'adminID': admin!.adminID,
      'waterPrice':facilities!.waterPrice,
      'gatoradePrice':facilities!.gatoradePrice,
      'kit':facilities!.kit,

      'playgroundName': playgroundName,
      'price': price,
      'type': type,
      'size': size,
      'payment':payment,
      'playgroundId': playgroundId,
    };
  }
}
