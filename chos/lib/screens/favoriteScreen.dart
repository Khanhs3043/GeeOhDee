
import 'package:chos/services/dbHelper.dart';
import 'package:chos/widgets/favoriteItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/dog.dart';
import '../providers/userProvider.dart';
class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}
class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Dog>? dogs;
  @override
  void initState() {
    loadData();
    super.initState();
  }
  loadData()async{
    dogs = await DbHelper.getListFavoriteDog(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
    });
  }
  Widget build(BuildContext context) {

    return Consumer<UserProvider>(
      builder: (context,provider,child){

      return Scaffold(
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.brown,Colors.blueGrey,Colors.white]
            )
          ),

          child: SingleChildScrollView(
            child: Column(
              children: [
                provider.state?SizedBox():SizedBox(),
                const SizedBox(height: 50,),
                Text('Your favorite',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                dogs==null?Center(child: CircularProgressIndicator()):Center(
                  child: Wrap(
                    spacing: 20,
                    children: dogs!.map((e) => FavoriteItem(dog: e)).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      );}
    );
  }
}
