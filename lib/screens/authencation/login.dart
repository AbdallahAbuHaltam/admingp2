import 'package:flutter/material.dart';

import '../../services/auth.dart';
import '../../utils/constants.dart';
import '../launch.dart';
import 'signup.dart';


class Login extends StatefulWidget {
  const Login({
    super.key,
  });

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  String error = '';

  bool _isObsecure = true;
  bool _valuefirst = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset('images/Rectangle 1.png'),
              const Text(signin),
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  withh,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SizedBox(
                width: 350,
                child: TextFormField(
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        labelText: eEmail,
                        isDense: true,
                        prefixIcon: Icon(Icons.email_outlined),
                        hintText: hEmail),
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    onChanged: (val) {
                      setState(() {
                        _emailcontroller.text = val;
                      });
                    },
                    onSaved: (value) {
                      _emailcontroller.text = value!;
                    },
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty ||
                          !value.contains('@')) {
                        return "Please Enter a valid Email address";
                      }
                      return null;
                    } //(value) =>
                    //value!.isEmpty ? "Enter an Email! " : null,

                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: 350,
                  child: TextFormField(
                      obscureText: _isObsecure,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          labelText: ePassword,
                          isDense: true,
                          prefixIcon: const Icon(Icons.key_rounded),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObsecure = !_isObsecure;
                                });
                              },
                              icon: Icon(_isObsecure
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          hintText: hPassword),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (val) {
                        setState(() {
                          _passwordcontroller.text = val;
                        });
                      },
                      onSaved: (value) {
                        _passwordcontroller.text = value!;
                      },
                      validator: (value) {
                        if (value == null || value.trim().length < 8) {
                          return "Password must be 8 char long";
                        }
                        return null;
                      } //(value) =>
                      //value!.length < 8 ? "Must be 8 length " : null,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 27.0),
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: mBackgroundColor,
                      activeColor: mRedColor,
                      value: _valuefirst,
                      onChanged: (value) {
                        setState(() {
                          _valuefirst = value!;
                        });
                      },
                    ),
                    const Text(
                      'Remember me',
                      style: TextStyle(fontSize: 14),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 98, bottom: 8),
                      child: Text(
                        'Forget your password?',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 29.0),
                child: SizedBox(
                    width: 350,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(mBackgroundColor),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(mRedColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _auth.userLogin(
                              email: _emailcontroller.text,
                              password: _passwordcontroller.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LaunchPage()),
                          );
                        }
                      },
                      child: const Text(
                        login,
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 330),
                child: Row(
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 14),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signup()),
                        );
                      },
                      child: const Text(
                        "$signup?",
                        style: TextStyle(
                          color: mRedColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 7, bottom: 7),
                child: Text(
                  'or',
                  style: TextStyle(fontSize: 13),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 95, right: 8),
                    child: GestureDetector(
                      child: Column(
                        children: [Image.asset('images/Facebook.png')],
                      ),
                      onTap: () async {},
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                      },
                      child: Column(
                        children: [
                          Image.asset('images/Google.png'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Image.asset('images/Apple Logo.png'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
