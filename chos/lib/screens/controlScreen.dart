import 'package:chos/models/myUser.dart';
import 'package:chos/providers/userProvider.dart';
import 'package:chos/screens/profileScreen.dart';
import 'package:chos/services/dbHelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/dogService.dart';
import 'favoriteScreen.dart';
import 'homeScreen.dart';
class ControlScreen extends StatefulWidget {
  const ControlScreen({super.key});

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}
class _ControlScreenState extends State<ControlScreen> {
  var selectedIndex =0;
  var user;
  @override
  didChangeDependencies() async{
    user = await DbHelper.getUserById(FirebaseAuth.instance.currentUser!.uid);
    Provider.of<UserProvider>(context,listen: false).user = user;
    await getListImage();
    super.didChangeDependencies();
  }
  // void initState() {
  //   getListImage();
  //   super.initState();
  // }
  Future getListImage()async{
    Provider.of<UserProvider>(context,listen: false).list5Url = await DogService.getRandomDogImage(5);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    var screens = [HomeScreen(), FavoriteScreen(), ProfileScreen()];
    return Scaffold(
      backgroundColor: Color(0xffededed),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.grey,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(
              label: 'Favorite',
              icon: Icon(Icons.favorite_border_outlined)),
          BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.account_circle))
        ],
        onTap: (index){
          setState(() {
            selectedIndex = index;
          });
        },

      ),
      body: user==null||Provider.of<UserProvider>(context,listen: false).list5Url!.isEmpty?const Center(child: CircularProgressIndicator(),):screens[selectedIndex],
    );
  }
}
