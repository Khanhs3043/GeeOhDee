import 'package:chos/widgets/breedItem.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/dog.dart';
import '../providers/userProvider.dart';
class BreedsScreen extends StatefulWidget {
  BreedsScreen({super.key});

  @override
  State<BreedsScreen> createState() => _BreedsScreenState();
}
class _BreedsScreenState extends State<BreedsScreen> {
  List<Dog>? dogs= [];
  @override
  void initState() {
    dogs = Provider.of<UserProvider>(context,listen: false).listDog;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffece6f3),
        centerTitle: true,
        title: Text('All breeds'),
      ),
      body: Consumer<UserProvider>(
        builder: (context,provider,child){
        return Stack(
          alignment: Alignment.center,
          children: [SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top:90,bottom: 30),
              child: Column(
                children: [
                  Column(
                    children: dogs!.map((dog) => BreedItem(dog: dog,)).toList(),
                  ),
                  TextButton(onPressed: ()async{
                    await provider.getMoreDogs();
                  }, child: Text('load more dogs')),
                  const SizedBox(height: 20,),
                ],
              ),
            ),
          ),
            Positioned(
              top:20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width-100,
                      child: SearchBar(
                        shadowColor: MaterialStatePropertyAll(Colors.black.withOpacity(0.6)),
                      )),
                  const SizedBox(width: 15,),
                  IconButton(
                      onPressed: (){},
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Color(0xffece6f3)),
                        shadowColor: MaterialStatePropertyAll(Colors.black.withOpacity(0.6)),
                        elevation: MaterialStatePropertyAll(5)
                      ),
                      padding: EdgeInsets.all(12),
                      icon: Icon(Icons.search,size: 30,))
                ],
              ),
            )
          ]
        );}
      ),
    );
  }
}
