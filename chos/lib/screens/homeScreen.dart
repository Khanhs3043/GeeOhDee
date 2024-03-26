import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chos/providers/userProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

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
  @override
  void didChangeDependencies() {
    listImage = Provider.of<UserProvider>(context,listen: false).list5Url;
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
                items: listImage?.map((src) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(src),
                              fit: BoxFit.cover,
                            ),
                              color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
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
                        onPressed: (){},
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
                      [1,2,3,4,5].map((e) => FeatureItem()).toList()
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
                    [1,2,3,4,5].map((e) => FeatureItem()).toList()
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
