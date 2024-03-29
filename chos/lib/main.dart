import 'package:chos/models/myColor.dart';
import 'package:chos/providers/userProvider.dart';
import 'package:chos/screens/controlScreen.dart';
import 'package:chos/screens/loginScreen.dart';
import 'package:chos/services/fb_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ?
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBNTR1XSHyCBeIM_rsLXIcaffu2KwkdzBI',  // current_key
          appId: '1:214694957563:android:38ba21ef224b69121efb5e',  // mobilesdk_app_id
          messagingSenderId: '214694957563',  // project_number
          projectId: 'deeohgee-b484e'  // project_id
      )
  ) : await Firebase.initializeApp();
  runApp(DeeOhGee());

}

class DeeOhGee extends StatefulWidget {
  const DeeOhGee({Key? key}) : super(key: key);

  @override
  _DeeOhGeeState createState() => _DeeOhGeeState();
}

class _DeeOhGeeState extends State<DeeOhGee> {
  bool staySignin = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuthService.authStateChanges.listen((user) {
      setState(() {
        staySignin = user != null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: staySignin ? ControlScreen() : LoginScreen(),
      ),
    );
  }
}
