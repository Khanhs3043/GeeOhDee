import 'package:chos/models/myUser.dart';
import 'package:chos/providers/userProvider.dart';
import 'package:chos/screens/loginScreen.dart';
import 'package:chos/screens/settingScreen.dart';
import 'package:chos/services/fb_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var nameCon = TextEditingController();
  var genderCon =   TextEditingController();
  var selectedGender = 'Female';
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context,user,child ){
        nameCon.text = user.user!.name;
        return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Align(alignment: Alignment.center,
                  child: CircleAvatar(radius: 60,)),
              Text('${user.user?.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  mText(text: 'Personal information'),
                  TextButton(onPressed: (){
                    showModalBottomSheet(context: context,
                        builder: (context)=>Container(
                          height: 500,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                TextField(
                                  controller:nameCon,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20)
                                    ),
                                    hintText: 'Name'
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Gender'),
                                    DropdownButton<String>(
                                      value: selectedGender,
                                        items: [
                                      DropdownMenuItem<String>(child: Text('Female'),value: 'Female',),
                                      DropdownMenuItem<String>(child: Text('Male'),value: 'Male',),
                                      DropdownMenuItem<String>(child: Text('Other'),value: 'Other',),
                                    ], onChanged: <String>(val){
                                        setState(() {
                                          selectedGender = val;
                                        });
                                    })
                                  ],
                                )
                              ],
                            ),
                          ),
                        ));
                  },
                      child: Text('Edit',style: TextStyle(color: Colors.blue,fontSize: 18),))
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: Offset(0,4),
                    blurRadius: 10
                  )]
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        mText(text: 'Name',color: Colors.black),
                        mText(text: '${user.user?.name}',),
                      ],
                    ),
                    Container(margin:EdgeInsets.symmetric(vertical: 10),color: Colors.grey.shade400,height: 1,width: MediaQuery.sizeOf(context).width,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        mText(text: 'Email',color: Colors.black),
                        mText(text: '${user.user?.email}',),
                      ],
                    ),
                    Container(margin:EdgeInsets.symmetric(vertical: 10),color: Colors.grey.shade400,height: 1,width: MediaQuery.sizeOf(context).width,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        mText(text: 'Gender',color: Colors.black),
                        mText(text: '${user.user?.gender}',),
                      ],
                    ),
                    Container(margin:EdgeInsets.symmetric(vertical: 10),color: Colors.grey.shade400,height: 1,width: MediaQuery.sizeOf(context).width,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        mText(text: 'Date of birth',color: Colors.black,),
                        mText(text: '${user.user?.dob}',),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerLeft,
                  child: mText(text: 'Setting')),
              const SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: Offset(0,4),
                        blurRadius: 10
                    )]
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        mText(text: 'Dark mode',color: Colors.black),
                        SizedBox(height:35,child: Switch(value: false, onChanged: (_){})),
                      ],
                    ),
                    Container(margin:EdgeInsets.symmetric(vertical: 10),color: Colors.grey.shade400,height: 1,width: MediaQuery.sizeOf(context).width,),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          mText(text: 'Log out',color: Colors.black,),
                          const Icon(
                            Icons.power_settings_new_outlined,
                            color: Colors.red,
                            size: 30,
                          )
                        ],
                      ),
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      );}
    );
  }
}
class mText extends StatelessWidget {
   mText({super.key,required this.text, this.color = Colors.grey});
String text;
Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 18,
        color: color
      ),
    );
  }
}

