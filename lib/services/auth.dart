import 'dart:async';

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
          adminID: value.user!.uid);
      User? user = value.user;
      userCollection
          .doc(value.user!.uid)
          .set(model.toMap())
          .then((value) => print('success'))
          .catchError((e) {
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
        final uid = value.data()?['uId'];
        admin.adminID = uid;
        admin.email = value.data()?['email'];
        admin.password = value.data()?['password'];
        admin.phoneNo = value.data()?['phoneNo'];

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

 
}
