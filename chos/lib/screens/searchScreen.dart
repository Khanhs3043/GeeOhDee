import 'package:chos/services/dogService.dart';
import 'package:chos/widgets/breedItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/dog.dart';
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();
  List<Dog>? searchList =[];
  Future search(String query)async{
    if(query.isEmpty) {
      searchList=[];
    } else {
      print('searching00000');
      searchList = await DogService.searchDogByName(query);
      print(searchList);
      setState(() {});
      //setState(() {
        //searchList = dogs!.where((e) => e.name!.toLowerCase().contains(query.toLowerCase())).toList();
      //});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 100,),
                searchList!.isEmpty?Center(child: Text('no dog found'),):
                Column(
                  children: searchList!.map((dog) => BreedItem(dog: dog)).toList(),
                )
              ],
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
                      hintText: 'Searching...',
                      trailing: [IconButton(onPressed: (){searchController.text='';},icon:Icon(Icons.clear))],
                      controller: searchController,
                      shadowColor: MaterialStatePropertyAll(Colors.black.withOpacity(0.6)),
                    )),
                const SizedBox(width: 15,),
                IconButton(
                    onPressed: ()async{
                      //searchController.text = '';

                     await search(searchController.text);
                    },
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
        ],
      ),
    );
  }
}
