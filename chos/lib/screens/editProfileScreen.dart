import 'package:chos/models/myUser.dart';
import 'package:chos/providers/userProvider.dart';
import 'package:chos/services/dbHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  var selectedGender;
  var nameCon = TextEditingController();
  var user;
  var dateOfBirth;
  @override
  void initState() {
    user = Provider.of<UserProvider>(context,listen:false).user;
    selectedGender = user?.gender ?? 'Female';
    nameCon.text = user!.name;
    dateOfBirth = user.dob?? DateTime.now();
    super.initState();
  }
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Edit your information'),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/back.jpg'),fit: BoxFit.fitHeight,opacity: 0.5),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white,Colors.black,]
          )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  children: [

                    TextField(
                      style:  TextStyle(fontSize: 18),
                      controller: nameCon,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 18),
                        hintText: 'Enter your name',
                        label: Text('Name')
                      ),
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Gender',style: TextStyle(fontSize: 18),),
                        DropdownButton(
                          value: selectedGender,
                            items: [
                          DropdownMenuItem(child: Text('Female',style: TextStyle(fontSize: 18),),value: 'Female',),
                          DropdownMenuItem(child: Text('Male',style: TextStyle(fontSize: 18),),value: 'Male',),
                          DropdownMenuItem(child: Text('Other',style: TextStyle(fontSize: 18),),value: 'Other',)
                        ],
                            onChanged: (val){
                            setState(() {
                              selectedGender = val;
                            });
                            })
                      ],
                    ),
                    GestureDetector(
                      onTap:()async{
                        var date  = await showDatePicker(context: context, firstDate: DateTime(1900), lastDate: DateTime.now());
                        setState(() {
                          dateOfBirth = date;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Date of birth',style: TextStyle(fontSize: 18),),
                          Text('${DateFormat('dd/MM/yyyy').format(dateOfBirth)}',style: TextStyle(fontSize: 18),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50,),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color(0xffffffff)),
                      foregroundColor: MaterialStatePropertyAll(Color(0xffde703b)),
                      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 10,horizontal: 70))
                  ),
                  onPressed: ()async{
                    MyUser? u = Provider.of<UserProvider>(context,listen:false).user;
                    print(u);
                    u?.name = nameCon.text;
                    u?.gender = selectedGender;
                    u?.dob = dateOfBirth;
                    await DbHelper.updateUser(u!);
                    Provider.of<UserProvider>(context,listen:false).user = await DbHelper.getUserById(u.id);
                    Provider.of<UserProvider>(context,listen:false).change();
                    Navigator.pop(context);
                  }, child: Text('Update',style: TextStyle(fontSize: 18),))
            ],
          ),
        ),
      ),
    );
  }
}
