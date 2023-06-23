import 'dart:async';

import 'package:admingp2/models/facilities.dart';
import 'package:admingp2/models/playground_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';
import '../models/admin.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("admin");

  Admin? _userfromFirebase(User user) {
    // ignore: unnecessary_null_comparison
    return user != null ? Admin(adminID: user.uid) : null;
  }

  Stream<Admin?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userfromFirebase(user!));
  }

  Future userSignup({
    required String email,
    String? adminName,
    required String password,
    String? phoneNo,
  }) async {
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.uid);
      print(value.user!.email);
      Admin model = Admin(
        email: email,
        password: password,
        phoneNo: phoneNo,
        adminID: value.user!.uid,
        adminName: adminName,
      );
      User? user = value.user;
      userCollection.add(model.toMap()).then((value) {
        final uid = model.adminID;
        admin.adminID = uid;
        admin.email = model.email;
        admin.password = model.password;
        admin.phoneNo = model.phoneNo;
        admin.adminName = model.adminName;

        print('success');
      }).catchError((e) {
        print(e.toString());
        _userfromFirebase(user!);
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future userLogin({required String email, required String password}) async {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      User? user = value.user;

      FirebaseFirestore.instance
          .collection('admin')
          .doc(value.user?.uid)
          .get()
          .then((value) {
        final uid = admin.adminID;
        admin.adminID = uid;
        admin.email = value.data()?['email'];
        admin.password = value.data()?['password'];
        admin.phoneNo = value.data()?['phoneNo'];
        admin.adminName = value.data()?['adminName'];

        if (uid != null) {
          print("Success Login");
        } else {
          print("Falied Login");
        }
        //getData(uId: uid);
        _userfromFirebase(user!);
      }).catchError((e) {
        print(e.toString());
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      return null;
    }
  }

  Future addPlaygroundData(
      {String? playgroundName,
      String? size,
      double? price,
      String? type,
      String? payment,
      Facilities? facilities}) async {
    FirebaseFirestore.instance
        .collection('playgroundInfo')
        .add(PlaygroundInfo(
          playgroundName: playgroundName,
          size: size,
          price: price,
          type: type,
          payment: payment,
          facilities: Facilities(
            water: "water",
            waterPrice: facilities!.waterPrice,
            gatorade: "gatorade",
            gatoradePrice: facilities.gatoradePrice,
            kit: facilities.kit,
          ),
          admin: Admin(
              adminID: admin.adminID,
              adminName: admin.adminName,
              email: admin.email,
              password: admin.password,
              phoneNo: admin.phoneNo),
        ).toMap())
        .then((value) {
      print("Success add Playground Data");
    });
  }

  Future addFacilities({
    String? water,
    double? waterPrice,
    String? gatorade,
    double? gatoradePrice,
    String? kit,
  }) async {
    FirebaseFirestore.instance
        .collection('Facilities')
        .add(Facilities(
                water: water,
                waterPrice: waterPrice,
                gatorade: gatorade,
                gatoradePrice: gatoradePrice,
                kit: kit)
            .toMap())
        .then((value) {
      print("Success add  Facilities Data");
    });
  }
}
