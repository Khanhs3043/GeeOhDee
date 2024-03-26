import 'package:chos/models/myUser.dart';
import 'package:chos/providers/userProvider.dart';
import 'package:chos/screens/loginScreen.dart';
import 'package:chos/screens/settingScreen.dart';
import 'package:chos/services/fb_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context,user,child ){
        return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          actions: [IconButton(onPressed: ()async{
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingsScreen()));

            },
              icon: Icon(Icons.settings,size: 30,))],
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Align(alignment: Alignment.center,
                  child: CircleAvatar(radius: 50,)),
              Text('${user.user?.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
            ],
          ),
        ),
      );}
    );
  }
}
