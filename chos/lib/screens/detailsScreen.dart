import 'dart:async';

import 'package:chos/services/dogService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../models/dog.dart';

class DetailsScreen extends StatefulWidget {
   DetailsScreen({super.key, required this.dog});
  Dog dog;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}
class _DetailsScreenState extends State<DetailsScreen> {
  List<String> urls = [] ;
  var selectedImage;
  @override
  void initState() {
    getPic();
    super.initState();
  }
  Future getPic()async{
    urls = [DogService.getImageStringByReferenceId(widget.dog.referenceImageId!)];
    selectedImage = urls[0];
    List<String> listPic = await DogService.getPicAboutBreed(widget.dog.id!);
    urls.addAll(listPic);
    print(urls);
    setState(() {});
  }
  Widget build(BuildContext context) {

    return urls==null?CircularProgressIndicator():Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 0,
              child: Container(
                height: MediaQuery.sizeOf(context).height/2,
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                    image: DecorationImage(image:NetworkImage(selectedImage),fit:BoxFit.cover ),
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
                         Center(child: Text('More pictures of ${widget.dog.name}',style: TextStyle(fontSize: 18,color: Colors.grey),)),
                        const SizedBox(height: 15,),
                         Container(

                           width: MediaQuery.sizeOf(context).width,
                           child: SingleChildScrollView(
                             scrollDirection: Axis.horizontal,
                             child: Row(
                               children: urls.map(
                                       (url) => GestureDetector(
                                         onTap: (){
                                           setState(() {
                                                  selectedImage = url;
                                           });
                                         },
                                         child: Container(
                                           width: 100,
                                           height: 100,
                                           margin: EdgeInsets.only(right: 15),
                                           decoration: BoxDecoration(
                                               borderRadius: BorderRadius.circular(10),
                                               image: DecorationImage(image: NetworkImage(url),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${widget.dog.name}',
                                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),),
                                  Row(
                                    children: [
                                      Icon(Icons.place_outlined,color: Colors.blueGrey,),
                                      Text('${widget.dog.origin}',style: TextStyle(fontSize: 20),),
                                    ],
                                  ),
                                ],
                              ),
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
                        Text('Weight: ${widget.dog.weight}'),
                        Text('Height: ${widget.dog.height}'),
                        Text('BredFor: ${widget.dog.bredFor}'),
                        Text('BreedGroup: ${widget.dog.breedGroup}'),
                        Text('LifeSpan: ${widget.dog.lifeSpan}'),
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
