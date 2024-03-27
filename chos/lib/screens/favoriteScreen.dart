import 'package:chos/services/dbHelper.dart';
import 'package:chos/widgets/breedItem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/dog.dart';
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
    print(dogs);
    setState(() {
    });
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: dogs==null?Center(child: CircularProgressIndicator()):Column(
        children: dogs!.map((e) => BreedItem(dog: e)).toList(),
      ),
    );
  }
}
