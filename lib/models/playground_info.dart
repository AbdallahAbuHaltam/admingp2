
import 'package:admingp2/models/admin.dart';

class PlaygroundInfo {
  Admin? admin;
   String? playgroundName;
   String? size;
   String? price;
   PlaygroundType? type;
   String? playgroundId;

  PlaygroundInfo(
      {this.admin,
         this.playgroundName,
      this.size,
      this.price,
      this.type,
      this.playgroundId,
      }
  );

  PlaygroundInfo.formJson(Map<String, dynamic>? json) {
     admin?.adminName = json?['adminName'];
    admin?.email = json?['email'];
    admin?.phoneNo = json?['phoneNo'];
    admin?.password = json?['password'];
    admin?.adminID = json?['adminID'];

    playgroundName = json?['playgroundName'];
    price = json?['price'];
    type = json?['type'];
    size = json?['size'];
    playgroundId = json?['playgroundId'];
  }

  

  Map<String, dynamic> toMap() {
    return {
       'adminName': admin!.adminName,
      'email': admin!.email,
      'phoneNo': admin!.phoneNo,
      'password': admin!.password,
      'adminID': admin!.adminID,
      'playgroundName': playgroundName,
      'price': price,
      'type': type,
      'size': size,
      'playgroundId': playgroundId,
    };
  }

}

enum PlaygroundType {
  football,
  basketballcourt,
  swimmingpool,
  running,
  tennis,
  padel
}