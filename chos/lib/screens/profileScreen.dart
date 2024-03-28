import 'dart:io';
import 'package:chos/providers/userProvider.dart';
import 'package:chos/screens/loginScreen.dart';
import 'package:chos/services/dbHelper.dart';
import 'package:chos/services/fb_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'editProfileScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var nameCon = TextEditingController();
  var genderCon =   TextEditingController();
  var selectedGender = 'Female';
  String ava='';
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
                  child: Stack(
                    children: [CircleAvatar(radius: 60,
                    backgroundImage: FileImage(File(user.user?.imageUrl??'')),
                    ),
                      Positioned(
                        bottom:-10,
                          right:-10,
                          child: IconButton(onPressed: ()async{
                            final picker = ImagePicker();
                            final pickedImage = await picker.pickImage(source: ImageSource.gallery);
                            showDialog(context: context, builder: (context)=>AlertDialog(
                              title: null,
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [TextButton(onPressed: ()async{
                                 await DbHelper.updateAvatar(user.user!, pickedImage!.path);
                                  user.user = await DbHelper.getUserById(user.user!.id);
                                  setState(() {
                                    ava = pickedImage!.path;
                                  });
                                  Navigator.pop(context);
                                }, child: Text('Save',style: TextStyle(color: Colors.blue,fontSize: 20),)),
                                  Container(height:40,width: 2,color: Colors.grey.shade400,),
                                  TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel',style: TextStyle(color: Colors.grey,fontSize: 20),))],
                              ),
                            ));
                          }, icon: const Icon(Icons.camera_alt,size: 30,color: Colors.grey,)))
                    ]
                  )),
              Text('${user.user?.name}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  mText(text: 'Personal information'),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen()));
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
                        mText(text: user.user?.dob==null?'No information':'${DateFormat('dd/MM/yyy').format(user.user!.dob!)}',),
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

