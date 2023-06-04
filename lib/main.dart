
import 'package:admingp2/models/admin.dart';
import 'package:admingp2/models/playground_info.dart';
import 'package:admingp2/services/auth.dart';
import 'package:admingp2/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

/*final File file=File('images/playersadi.json');
  final String jsonString=file.readAsStringSync();
  final Map<String,dynamic> map=json.decode(jsonString);
  final Players players = Players.formJson(map);*/
 final Admin admin =Admin();
void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Admin?>.value(
      value: AuthService().user,
      initialData: null,
      child: const MaterialApp(
        home: Wrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
