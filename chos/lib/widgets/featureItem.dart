import 'package:chos/screens/detailsScreen.dart';
import 'package:chos/services/dogService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../models/dog.dart';

class FeatureItem extends StatelessWidget {
   FeatureItem({super.key, required this.dog});
    Dog dog;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(dog: dog)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(15),
        width: 150,
        height: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(
                blurRadius: 10,
                offset: Offset(0,4),
                color: Colors.black.withOpacity(0.1)
            )]
        ),
        child: Column(
          children: [Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 120,
                decoration: BoxDecoration(
                  color: Color(0xff92a3a6),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(DogService.getImageStringByReferenceId(dog.referenceImageId!)),
                      fit: BoxFit.cover)
                ),
              ),
              const SizedBox(height: 10,),
              Text('${dog.name}',style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),overflow: TextOverflow.ellipsis,),
              //const SizedBox(height: 10,),

            ],
          ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.place_outlined,color: Colors.blueGrey,),
                  Expanded(child: Text('${dog.origin}',style: TextStyle(fontSize: 16),overflow: TextOverflow.ellipsis,)),
                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}
