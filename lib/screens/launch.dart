import 'package:flutter/material.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(
        seconds: 4,
      ),
      () => Navigator.pushReplacementNamed(context, '/list_page'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 0, 22, 50),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 500,
                width: double.infinity,
                child: Image.asset(
                    'images/Screenshot 2023-05-08 at 3.18.49 AM.png'),
              ),
              const Text(
                'Derbyjo',
                style: TextStyle(
                  color: Color.fromARGB(255, 240, 220, 200),
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  letterSpacing: 5,
                  wordSpacing: 5,
                ),
              ),
              const Text(
                'Bussines APP',
                style: TextStyle(
                    color: Color.fromARGB(255, 240, 220, 200),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 5,
                    height: 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
