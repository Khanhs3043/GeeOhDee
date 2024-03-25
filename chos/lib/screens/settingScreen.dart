import 'package:chos/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/fb_auth.dart';
import 'loginScreen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe7e7e7),
      appBar: AppBar(
        foregroundColor: Colors.black,
        title: Text('Settings'),
        backgroundColor: Colors.white,
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Darkmode",
                        style: TextStyle(
                            fontSize: 17, color:Colors.black),
                      ),
                      Switch(
                          value:true,// ui.isDark,
                          activeColor: Colors.cyan.shade300,
                          activeTrackColor: Colors.grey.shade300,
                          onChanged: (isDark) {
                            //ui.switchTheme();
                          })
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Language",
                        style: TextStyle(
                            fontSize: 17, color: Colors.black),
                      ),
                      Switch(
                          value: false,
                          onChanged: (_) {

                          })
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('You want to sign out ?'),
                            actions: [
                              TextButton(
                                  onPressed: () async{
                                    FirebaseAuthService s =FirebaseAuthService();
                                    await s.signOut();
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                                  },
                                  child: Text('OK')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel'))
                            ],
                          );
                        });
                  },
                  child: Container(
                    height: 60,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Log Out",
                          style: TextStyle(
                              fontSize: 17, color: Colors.black),
                        ),
                        const Icon(
                          Icons.power_settings_new_outlined,
                          color: Colors.red,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
