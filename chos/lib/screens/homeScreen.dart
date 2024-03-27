import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chos/providers/userProvider.dart';
import 'package:chos/screens/searchScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/dog.dart';
import '../services/dogService.dart';
import '../widgets/featureItem.dart';
import 'breedsScreen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String>? listImage=[];
  List<Dog>? listDog =[];
  List<Dog>? list4Carousel = [];
  @override
  void initState() {
    super.initState();
    listImage = Provider.of<UserProvider>(context,listen: false).list5Url;
    listDog = Provider.of<UserProvider>(context,listen: false).listDog?.sublist(0,10);
    List<Dog>? shuffleList = listDog;
    shuffleList?.shuffle();
    list4Carousel = shuffleList?.sublist(0,5);
  }
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<UserProvider>(context,listen: false).state;
    return Consumer<UserProvider>(
      builder: (context,provider,child){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Icon(Icons.pets_outlined,color: Colors.blueGrey,),
              const SizedBox(width: 10,),
              Text('Welcome ${provider.user?.name} !',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blueGrey),)
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              CarouselSlider(
                options: CarouselOptions(
                    height: 180.0,
                    viewportFraction: 1,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 5)
                ),
                items: list4Carousel?.map((dog) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(DogService.getImageStringByReferenceId(dog.referenceImageId!)),
                              fit: BoxFit.cover,
                            ),
                              color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10,right: 20),
                              child: Text('${dog.name}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30, color: Colors.white),textDirection: TextDirection.rtl,),
                            )),
                      );
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));
                        },
                        icon: Icon(Icons.search),
                        label: Text('Search'),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>BreedsScreen()));
                        },
                        icon: Icon(Icons.pets_outlined),
                        label: Text('Breeds'),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Feature',style: TextStyle(fontSize: 18),),
              ),
              const SizedBox(height: 10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,bottom: 20),
                  child: Row(
                    children:
                      listDog!.map((dog) => FeatureItem(dog: dog)).toList()
                    ,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Feature',style: TextStyle(fontSize: 18),),
              ),
              const SizedBox(height: 10,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,bottom: 20),
                  child: Row(
                    children:
                    listDog!.map((dog) => FeatureItem(dog: dog)).toList()
                    ,
                  ),
                ),
              )
            ],
          ),
        ),
      );}
    );
  }
}
