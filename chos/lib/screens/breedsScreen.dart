import 'package:chos/widgets/breedItem.dart';
import 'package:flutter/material.dart';
class BreedsScreen extends StatefulWidget {
  const BreedsScreen({super.key});

  @override
  State<BreedsScreen> createState() => _BreedsScreenState();
}

class _BreedsScreenState extends State<BreedsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffece6f3),
        centerTitle: true,
        title: Text('All breeds'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top:90,bottom: 30),
            child: Column(
              children: [1,2,3,4,5,6].map((e) => BreedItem()).toList(),
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
      ),
    );
  }
}
