import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../utils/constants.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({
    super.key,
  });

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _adminnamecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();

  String error = '';

  bool _isObsecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: mBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(85, 0, 0, 0),
              child: Text(
                signup,
                style: TextStyle(
                    fontSize: 25,
                    color: mBlackColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 50,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 3),
              child: Image.asset("images/Rectangle 2.png"),
            )
          ],
        ),
        elevation: 0,
        backgroundColor: mBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: mBlackColor,
          ),
        ),
      ),
      //),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 260, 10),
                      child: Text(
                        emailA,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? "Enter an Email! " : null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        labelText: emailA,
                        isDense: true,
                        prefixIcon: Icon(Icons.email_rounded),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (val) {
                        _emailcontroller.text = val;
                      },
                      onSaved: (value) {
                        _emailcontroller.text = value!;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 280, 10),
                      child: Text(
                        userN,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        labelText: "Admin name",
                        isDense: true,
                        prefixIcon: Icon(Icons.person_2_sharp),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value!.isEmpty ? "Enter AdminName! " : null,
                      onChanged: (val) {
                        _adminnamecontroller.text = val;
                      },
                      onSaved: (value) {
                        _adminnamecontroller.text = value!;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 250, 10),
                      child: Text(
                        mobileN,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        labelText: mobileN,
                        isDense: true,
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                          value!.length < 10 ? "Must be 10 length " : null,
                      onChanged: (val) {
                        _phonecontroller.text = val;
                      },
                      onSaved: (value) {
                        _phonecontroller.text = value!;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 280, 10),
                      child: Text(
                        pass,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) =>
                          value!.length < 8 ? "Must be 8 length " : null,
                      obscureText: _isObsecure,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        labelText: pass,
                        isDense: true,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObsecure = !_isObsecure;
                              });
                            },
                            icon: Icon(_isObsecure
                                ? Icons.visibility
                                : Icons.visibility_off)),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (val) {
                        _passwordcontroller.text = val;
                      },
                      onSaved: (value) {
                        _passwordcontroller.text = value!;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 220, 10),
                      child: Text(
                        "Confirm $pass",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    TextFormField(
                      obscureText: _isObsecure,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        labelText: pass,
                        isDense: true,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isObsecure = !_isObsecure;
                              });
                            },
                            icon: Icon(_isObsecure
                                ? Icons.visibility
                                : Icons.visibility_off)),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) =>
                          value!.length < 8 ? "Must be 8 length " : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: SizedBox(
                          height: 45,
                          width: 300,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  mBackgroundColor),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(mRedColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _auth.userSignup(
                                  adminName: _adminnamecontroller.text,
                                  email: _emailcontroller.text,
                                  password: _passwordcontroller.text,
                                  phoneNo: _phonecontroller.text,
                                );
                              }
                            },
                            child: const Text(
                              signup,
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(160, 0, 0, 12),
                  child: Row(
                    children: [
                      const Text(haveA,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          )),
                      TextButton(
                        style: TextButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 13),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        child: const Text(
                          signin,
                          style: TextStyle(color: mRedColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Text(
                  error,
                  style: const TextStyle(color: mRedColor, fontSize: 12),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
