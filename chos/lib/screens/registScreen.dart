import 'package:chos/models/myUser.dart';
import 'package:chos/services/dbHelper.dart';
import 'package:chos/services/fb_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginScreen.dart';
class RegistScreen extends StatelessWidget {
   const RegistScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuthService();
    var passCon = TextEditingController();
    var emailCon =  TextEditingController();
    var nameCon = TextEditingController();
    var confirmCon =  TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100,),
              const Icon(Icons.pets_rounded,size: 70,color: Colors.blueGrey,),
              const Text('DeeOhGees!', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800,color: Colors.blueGrey),),
              const SizedBox(height: 20,),
              TextField(
                controller: nameCon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xffbfbfbf)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Your name',
                  prefixIcon:  Icon(Icons.medical_information_outlined),
                ),
              ),
          
              const SizedBox(height: 15,),
              TextField(
                controller: emailCon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Email ',
                  prefixIcon:  Icon(Icons.alternate_email),
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: passCon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Password ',
                  prefixIcon:  Icon(Icons.lock_open_outlined),
                ),
              ),
              const SizedBox(height: 15,),
              TextField(
                controller: confirmCon,
          
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: 'Confirm password ',
                  prefixIcon:  Icon(Icons.lock_open_outlined),
                ),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: ()async{
                  if(nameCon.text.isEmpty || emailCon.text.isEmpty ||passCon.text.isEmpty ||confirmCon.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please fill out all fields !"),
                    ));
                  }else {
                    if(confirmCon.text!=passCon.text){
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Confirm password does not match"),
                      ));
                    } else{
                  User? user = await auth.registerUserWithEmailAndPassword(
                      emailCon.text, passCon.text);
          
                  if (user != null) {
          
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Đã đăng ký thành công."),
                    ));
                    await DbHelper.createUser(MyUser(
                        id: user.uid,
                        name: nameCon.text,
                        email: user.email!,
                        ));

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("something went wrong!"),
                    ));
                  }
                }}},
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.symmetric(vertical:13),
                  decoration: BoxDecoration(
                      color:  Color(0xfff4c4ad),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Text('Register',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
