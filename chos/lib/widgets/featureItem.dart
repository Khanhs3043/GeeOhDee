import 'package:chos/screens/detailsScreen.dart';
import 'package:flutter/material.dart';

class FeatureItem extends StatelessWidget {
  const FeatureItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen()));
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 120,
              decoration: BoxDecoration(
                color: Color(0xff92a3a6),
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            const SizedBox(height: 10,),
            Text('Name of Dog',style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
            //const SizedBox(height: 10,),
            Text('origin',style: TextStyle(fontSize: 16),)
          ],
        ),
      ),
    );
  }
}
