import 'package:chos/providers/userProvider.dart';
import 'package:chos/screens/detailsScreen.dart';
import 'package:chos/services/dbHelper.dart';
import 'package:chos/services/dogService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/dog.dart';
class FavoriteItem extends StatelessWidget {
   FavoriteItem({super.key, required this.dog,required this.onDelete});
   Dog dog;
   final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:20,),
      height: 200,
      width: MediaQuery.sizeOf(context).width/2-30,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        image: DecorationImage(
          image: NetworkImage(DogService.getImageStringByReferenceId(dog.referenceImageId!)),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(dog: dog))).then((canRebuild) => onDelete());
          },
          onLongPress: (){
            showDialog(context: context, builder: (context)=>AlertDialog(
              title: null,
              actions: [TextButton(onPressed: ()async{
                await DbHelper.removeFavorite(dog.id!, FirebaseAuth.instance.currentUser!.uid);
                onDelete();
                Navigator.pop(context);
              }, child: Text('Delete',style: TextStyle(color: Colors.red),)),
                TextButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel',style: TextStyle(color: Colors.grey),))],
            ));
          },
          child: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black.withOpacity(0.3),

            ),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Positioned(
                  top:0,
                    right: 0,
                    child: Icon(Icons.favorite,color: Colors.white,)),
                Expanded(
                    child: Text('${dog.name}',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold,color: Colors.white,),)),
              ],
            ),
          ),
        ),
      )
    );
  }
}
