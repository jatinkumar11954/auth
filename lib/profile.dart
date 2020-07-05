import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:io';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String name,phone,email,college,linkedln;
  

  @override
  void initState(){
    super.initState();
    getDetails();
  }

 getDetails()async{
  SharedPreferences prefs= await SharedPreferences.getInstance();
 setState(() {
    name=(prefs.getString("user")??"");
    phone=(prefs.getString("phn")??"");
    email=(prefs.getString("email")??"");
    college=(prefs.getString("clg")??"Not Available");
     linkedln=(prefs.getString("linkedln")??"Not Available");
 });

  
}




  File _image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      backgroundColor: Colors.greenAccent,
      body: Align(
        alignment: Alignment.center,
              child: Column(
          
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: 50.0
              ),
                          child: _image == null ? CircleAvatar(child:Icon(Icons.person,size: 50.0,),radius: 50.0,) :CircleAvatar(
              radius:50.0,
              child:Container(
                decoration: BoxDecoration(
                  shape:BoxShape.rectangle,
                  
                              ),
              
                 
                alignment:Alignment.center,
                child: Image.file(_image,fit:BoxFit.contain),
              )  ,

          ),
            ),
          SizedBox(
            height: 30.0,
          ),
          Card(
            
            
            borderOnForeground: true,
            elevation:20.0,
            margin: EdgeInsets.all(20.0),
            child:Column(
              children:<Widget>[
                Row(
                  children:<Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Name: ",style: TextStyle(fontSize:25.0,fontWeight:FontWeight.bold,wordSpacing: 10.0)),
                    ),
                    Text("$name",style: TextStyle(fontSize:20.0,fontFamily: 'Playball'),),
                  ]
                ),
                Row(
                  children:<Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Phone: ",style: TextStyle(fontSize:25.0,fontWeight:FontWeight.bold,wordSpacing: 10.0),),
                    ),
                    Text("$phone",style: TextStyle(fontSize:20.0,fontFamily: 'Playball'),),
                  ]
                ),
                Row(
                  children:<Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Email: ",style: TextStyle(fontWeight:FontWeight.bold,wordSpacing: 10.0,fontSize: 25.0),),
                    ),
                    Text("$email",style: TextStyle(fontSize:20.0,fontFamily: 'Playball'),),
                  ]
                ),
                Row(
                  children:<Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text("College: ",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25.0)),
                  ),
                    Text("$college",style: TextStyle(fontSize:20.0,fontFamily: 'Playball'),),
                  ]
                ),
                Row(
                  children:<Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("Linkedln ID: ",style: TextStyle(fontWeight:FontWeight.bold,fontSize: 25.0),),
                    ),
                    Text("$linkedln",style: TextStyle(fontSize:20.0,fontFamily: 'Playball'),),
                  ]
                ),
              ]
            )
            
          )
          ] 
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:_dialogbox,     
        
        child: Icon(Icons.add_a_photo),
        tooltip: 'open camera',
      ),
    );
  }

  Future openCamera() async {
  
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future openGallery() async {
    
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = picture;
    });
  }

  Future<void> _dialogbox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(),
            content: SingleChildScrollView(
                child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('Take a photo',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                  onTap: openCamera,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                ),
                GestureDetector(
                  child: Text('select from gallery',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                  onTap: openGallery,
                ),
              ],
            )),
          );
        });
  }
}