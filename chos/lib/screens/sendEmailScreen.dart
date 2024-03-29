import 'package:flutter/material.dart';

import '../services/fb_auth.dart';
class SendEmailScreen extends StatelessWidget {
  const SendEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuthService();
    var emailCon =  TextEditingController();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.blueGrey,
      ),
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
                  hintText: 'Enter your Email ',
                  prefixIcon:  Icon(Icons.alternate_email),
                ),
              ),
              const SizedBox(height: 15,),
              GestureDetector(
                onTap: ()async{
                  await auth.passwordReset(emailCon.text.trim(), context);
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.symmetric(vertical:13),
                  decoration: BoxDecoration(
                      color:  Color(0xff89b9b9),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Text('Reset password',style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
