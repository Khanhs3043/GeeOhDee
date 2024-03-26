
import 'package:chos/screens/controlScreen.dart';
import 'package:chos/screens/registScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/fb_auth.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {
  var auth = FirebaseAuthService();
  var passCon = TextEditingController();
  var emailCon =  TextEditingController();
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

            const SizedBox(height: 30,),
            GestureDetector(
              onTap: ()async{
                User? user = await auth.loginUserWithEmailAndPassword(
                    emailCon.text, passCon.text);

                if (user != null) {

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Đăng nhập thành công"),
                  ));
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ControlScreen()),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("something went wrong!"),
                  ));
                }
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.symmetric(vertical:13),
                decoration: BoxDecoration(
                    color:  Color(0xff89b9b9),
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Text('Sign in',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ),
            ),
            const SizedBox(height: 10,),
            Text('Or create an account'),
            const SizedBox(height: 10,),
            GestureDetector(
              onTap: ()async{
               Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistScreen()));
              },
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
