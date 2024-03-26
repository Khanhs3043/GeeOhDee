import 'dart:math';

import 'package:chos/screens/detailsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class BreedItem extends StatelessWidget {
  const BreedItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen()));
      },
      child: Container(
        margin: EdgeInsets.only(top: 15,left: 20,right: 20),
        padding: EdgeInsets.only(right:20),
        decoration: BoxDecoration(
          color: Colors.white,
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
                  color: Colors.blueGrey
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
                    Text('Shiba inu',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Height',style: TextStyle(color: Colors.grey,fontSize: 16),),
                        Text('80-120',style: TextStyle(color: Colors.black,fontSize: 16),),
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Weight',style: TextStyle(color: Colors.grey,fontSize: 16),),
                        Text('12-22',style: TextStyle(color: Colors.black,fontSize: 16),),
                      ],
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Origin',style: TextStyle(color: Colors.grey,fontSize: 16),),
                        Text('Japan',style: TextStyle(color: Colors.black,fontSize: 16),),
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
