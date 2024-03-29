import 'dart:math';

import 'package:chos/screens/detailsScreen.dart';
import 'package:chos/services/dogService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/dog.dart';
import '../providers/userProvider.dart';
class BreedItem extends StatelessWidget {
   BreedItem({super.key,required this.dog});
  Dog dog;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(dog: dog,)));
      },
      child: Container(
        margin: EdgeInsets.only(top: 15,left: 20,right: 20),
        padding: EdgeInsets.only(right:20),
        decoration: BoxDecoration(
          color: Provider.of<UserProvider>(context).color.background2,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(
            blurRadius: 10,
            offset: Offset(0,4),
            color: Colors.black.withOpacity(0.15)
          )]
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blueGrey,
                  image: DecorationImage(
                      image: NetworkImage(DogService.getImageStringByReferenceId(dog.referenceImageId!)),
                      fit: BoxFit.cover)
                ),
              ),
            ),
            const SizedBox(width: 20,),
            Expanded(
              flex: 5,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${dog.name}',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis,
                    color: Provider.of<UserProvider>(context).color.text),),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Height',style: TextStyle(color: Colors.grey,fontSize: 16),),
                        Text('${dog.height} cm',style: TextStyle(color: Provider.of<UserProvider>(context).color.text,fontSize: 16),),
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Weight',style: TextStyle(color: Colors.grey,fontSize: 16),),
                        Text('${dog.weight} kg',style: TextStyle(color: Provider.of<UserProvider>(context).color.text,fontSize: 16),),
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text('Origin',style: TextStyle(color: Colors.grey,fontSize: 16),),
                        ),
                        Expanded(child: Text('${dog.origin}',style: TextStyle(color: Provider.of<UserProvider>(context).color.text,fontSize: 16,overflow: TextOverflow.ellipsis),textDirection: TextDirection.rtl,)),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
