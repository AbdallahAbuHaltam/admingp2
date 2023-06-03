class Admin{
String? email;
  String? adminName;
  String? password;
  String? phoneNo;
  String? adminID;

  Admin({
    this.email,
    this.adminName,
    this.password,
    this.phoneNo,
    this.adminID,
  });
  Admin.formJson(Map<String, dynamic>? json) {
    adminName = json?['adminName'];
    email = json?['email'];
    phoneNo = json?['phoneNo'];
    password = json?['password'];
    adminID = json?['adminID'];
  }

  

  Map<String, dynamic> toMap() {
    return {
      'adminName': adminName,
      'email': email,
      'phoneNo': phoneNo,
      'password': password,
      'adminID': adminID,
    };
  }

  

}