import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:chos/providers/userProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context,provider,child){
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Icon(Icons.pets_outlined),
              const SizedBox(width: 10,),
              Text('Hi ${provider.user?.name}!')
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
                items: [1,2,3,4,5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 20.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(child: Text('image $i', style: TextStyle(fontSize: 16.0),))
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
                        onPressed: (){},
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
                      [1,2,3,4,5].map((e) => Container(
                        margin: EdgeInsets.only(right: 15),
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
                      )).toList()
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
                    [1,2,3,4,5].map((e) => Container(
                      margin: EdgeInsets.only(right: 15),
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
                    )).toList()
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
