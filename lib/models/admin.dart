class Admin {
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
