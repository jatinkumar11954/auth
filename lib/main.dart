import 'package:flutter/material.dart';
import 'homescreen.dart';
import 'profile.dart';
import 'splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'first.dart';
import "fingerprint.dart";

bool jwt;


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primaryColor: Colors.lightBlueAccent
        
        
        
      ),
      initialRoute: jwt? "fingerprint":"splash",
      darkTheme: ThemeData.dark(),
      routes: <String,WidgetBuilder>{

        "splash":(context)=>SplashScreen(),
        "home":(context)=>HomeScreen(),
        "first":(context)=>FirstScreen(),
        "/profile":(context)=>HomePage(),
        "fingerprint":(context)=> FingerPrint(),
        
        // "/todo":(context)=>ToDo(),
        // "/music":(context)=>MusicScreen()

      },
      

    );
  }
}

Future<void> main() 
async{
    WidgetsFlutterBinding.ensureInitialized();
SharedPreferences prefs=await SharedPreferences.getInstance();
jwt=prefs.getBool("verifyUser")??false ;


print(jwt);
  runApp(App());
}