import 'dart:async';

import 'package:chos/models/favoriteDog.dart';
import 'package:chos/providers/userProvider.dart';
import 'package:chos/services/dbHelper.dart';
import 'package:chos/services/dogService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/dog.dart';

class DetailsScreen extends StatefulWidget {
   DetailsScreen({super.key, required this.dog});
  Dog dog;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}
class _DetailsScreenState extends State<DetailsScreen> {
  List<String> urls = [] ;
  bool isFavorite = false;
  var selectedImage;
  @override
  void initState() {
    checkFavorite();
    getPic();
    super.initState();
  }
  Future<void> checkFavorite()async{
    isFavorite = await DbHelper.isFavoriteExist(widget.dog.id!,  FirebaseAuth.instance.currentUser!.uid);
    setState(() {

    });
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
                              onTap: ()async{
                                bool exist = await DbHelper.isFavoriteExist(widget.dog.id!,  FirebaseAuth.instance.currentUser!.uid);
                                if (exist){
                                  await DbHelper.removeFavorite(widget.dog.id!,  FirebaseAuth.instance.currentUser!.uid);
                                  isFavorite = false;
                                  Provider.of<UserProvider>(context,listen: false).change();
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text('Unfavorited!')));
                                }else{
                                  await DbHelper.addFavorite(FavoriteDog( dog: widget.dog, userId: FirebaseAuth.instance.currentUser!.uid));
                                  isFavorite = true;
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text('Favorited!')));
                                }
                                setState(() {});
                              },
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                                child: isFavorite?Icon(Icons.favorite,color: Colors.pink,size: 33,):Icon(Icons.favorite_border_outlined,color: Colors.pink,size: 30,),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.all(10),
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xffececed),
                                    boxShadow: [BoxShadow(offset: Offset(0,4),blurRadius: 10,color: Colors.black.withOpacity(0.2))]
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Icon(Icons.fitness_center,color: Colors.white,size: 30,),
                                    Text('Weight (kg)',style: TextStyle(fontSize: 16,color: Colors.grey),),
                                    Text('${widget.dog.weight}',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.cyan),),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.all(10),
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xffececed),
                                    boxShadow: [BoxShadow(offset: Offset(0,4),blurRadius: 10,color: Colors.black.withOpacity(0.2))]
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Icon(Icons.fitness_center,color: Colors.white,size: 30,),
                                    Text('Height (cm)',style: TextStyle(fontSize: 16,color: Colors.grey),),
                                    Text('${widget.dog.height}',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.cyan),),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                margin: EdgeInsets.all(10),
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xffececed),
                                    boxShadow: [BoxShadow(offset: Offset(0,4),blurRadius: 10,color: Colors.black.withOpacity(0.2))]
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Icon(Icons.fitness_center,color: Colors.white,size: 30,),
                                    Text('Life span',style: TextStyle(fontSize: 16,color: Colors.grey),),
                                    Text('${widget.dog.lifeSpan?.substring(0,8)}',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.cyan),),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.pets_rounded,color: Colors.brown.shade400,),
                                  Expanded(child: Text(' BredFor: ${widget.dog.bredFor}',style: TextStyle(color: Colors.grey,fontSize: 18))),
                                ],
                              ),
                              const SizedBox(height: 7,),
                              Row(
                                children: [
                                  Icon(Icons.pets_rounded,color: Colors.brown.shade400,),
                                  Text('BreedGroup: ${widget.dog.breedGroup}',style: TextStyle(color: Colors.grey,fontSize: 18)),
                                ],
                              ),
                              const SizedBox(height: 7,),
                              Row( crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.pets_rounded,color: Colors.brown.shade400,),
                                  Expanded(child: Text('Temperament: ${widget.dog.temperament}',style: TextStyle(color: Colors.grey,fontSize: 18))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    ]
                  ),
                ),
              )
          ),
          // Positioned(
          //   bottom: 20,
          //   child: ElevatedButton.icon(
          //     onPressed: (){},
          //     icon: Icon(Icons.favorite_border_outlined),
          //     label: Text('Add to favorites list'),
          //   ),
          // ),
          Positioned(
            top:25,
            left: 10,
              child: IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.grey.withOpacity(0.4))
                ),
            color: Colors.white,
            icon: Icon(Icons.arrow_back,size: 30,),
            onPressed: (){Navigator.pop(context,isFavorite);},))
        ],
      ),
    );
  }
}
