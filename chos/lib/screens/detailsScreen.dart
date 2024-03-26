import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var urls = ["https:\/\/images.dog.ceo\/breeds\/shiba\/shiba-13.jpg",
    "https:\/\/images.dog.ceo\/breeds\/shiba\/shiba-19.jpg",
    "https:\/\/images.dog.ceo\/breeds\/shiba\/shiba-3i.jpg",
    "https:\/\/images.dog.ceo\/breeds\/shiba\/shiba-4.jpg",
    "https:\/\/images.dog.ceo\/breeds\/shiba\/shiba-6.jpg"];
  var selectedImage = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 0,
              child: Container(
                height: MediaQuery.sizeOf(context).height/2,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    image: DecorationImage(image:NetworkImage(urls[selectedImage]),fit:BoxFit.cover ),
                    color: Colors.grey
                ),
              )
          ),
          Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                height: MediaQuery.sizeOf(context).height*4/7,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(0)),
                  boxShadow: [BoxShadow(
                    offset: Offset(0,-4),
                    blurRadius: 15,
                    color: Colors.black.withOpacity(0.3)
                  )],
                ),
                child: SingleChildScrollView(
                  child: Stack(
                    children: [Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Center(child: Text('More pictures of shiba',style: TextStyle(fontSize: 18,color: Colors.grey),)),
                        const SizedBox(height: 15,),
                         Container(

                           width: MediaQuery.sizeOf(context).width,
                           child: SingleChildScrollView(
                             scrollDirection: Axis.horizontal,
                             child: Row(
                               children: [0,1,2,3,4].map(
                                       (index) => GestureDetector(
                                         onTap: (){
                                           setState(() {
                                                  selectedImage = index;
                                           });
                                         },
                                         child: Container(
                                           width: 100,
                                           height: 100,
                                           margin: EdgeInsets.only(right: 15),
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(10),
                                               image: DecorationImage(image: NetworkImage(urls[index]),
                                               fit: BoxFit.cover)
                                           ),
                                         ),
                                       )
                               ).toList(),
                             )
                           ),
                         ),
                        const SizedBox(height: 20,),

                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Shiba inu',
                                  style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
                                Row(
                                  children: [
                                    Icon(Icons.place_outlined,color: Colors.blueGrey,),
                                    Text('Japan',style: TextStyle(fontSize: 20),),
                                  ],
                                ),
                              ],
                            ),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: Icon(Icons.favorite_border_outlined,color: Colors.pink,size: 30,),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Text('weight: 12-15'),
                        Text('height: 100-120'),
                        Text('bredFor: 100-120'),
                        Text('breedGroup: 100-120'),
                        Text('lifeSpan: 100-120'),
                      ],

                    ),

                    ]
                  ),
                ),
              )
          ),
          Positioned(
            bottom: 20,
            child: ElevatedButton.icon(
              onPressed: (){},
              icon: Icon(Icons.favorite_border_outlined),
              label: Text('Add to favorites list'),
            ),
          ),
          Positioned(
            top:25,
            left: 10,
              child: IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.grey.withOpacity(0.4))
                ),
            color: Colors.white,
            icon: Icon(Icons.arrow_back,size: 30,),
            onPressed: (){Navigator.pop(context);},))
        ],
      ),
    );
  }
}
