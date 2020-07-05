import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'homescreen.dart';
import 'signup.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final namecontroller = TextEditingController();
  final passcontroller = TextEditingController();
  String name, pass;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getDetails() async {
    print("inside get");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = await prefs.getString("user") ?? null;
    print(name);
    pass = await prefs.getString("pass") ?? null;
  }

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    passcontroller.dispose();
  }

  bool _secureText = true;

  void toggle() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: Colors.lightBlueAccent,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                    // shrinkWrap: true,
                    // scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Container(
                        height: 100.0,
                        margin: EdgeInsets.only(top: 105.0, left: 14),
                        width: double.infinity,
                        child: Text(
                          "Welcome to Task App",
                          style: TextStyle(
                            fontSize: 35.0,
                            fontFamily: 'Schyler',
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 9,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: namecontroller,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Enter your Username";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Enter Username",
                            border: const OutlineInputBorder(),
                            icon: const Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: const Icon(Icons.lock)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 9,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          controller: passcontroller,
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            border: const OutlineInputBorder(),
                            icon: const Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: const Icon(Icons.lock)),
                          ),
                          validator: (val) =>
                              val.length < 6 ? 'Password too short.' : null,
                          obscureText: _secureText,
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 12,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: RaisedButton(
                          onPressed: () async{
                            if (_formKey.currentState.validate()) {
                              print("validated");
                              setState(() {
                                _isLoading = true;
                              });
                          await    getDetails();
                              // ignore: unrelated_type_equality_checks
                              if (name != null && pass != null) {
                                if (namecontroller.text == name &&
                                    // ignore: unrelated_type_equality_checks
                                    passcontroller.text == pass) {
                                  print("verified");
                                  namecontroller.clear();
                                  passcontroller.clear();
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()));
                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                              _scaffoldkey.currentState.showSnackBar(    SnackBar(
                                      content: Text("Inavlid Credentials")));
                                }
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                                         _scaffoldkey.currentState.showSnackBar(  SnackBar(content: Text("Please Sign Up")));
                              }
                              // ;
                              // }

                            }
                          },
                          elevation: 10.0,
                          child: _isLoading
                              ? CircularProgressIndicator()
                              : Text("Sign In"),
                          color: Colors.redAccent,
                        ),
                      ),
                      SizedBox(height: 50.0),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 12,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
                              },
                              child: Text("Sign Up"),
                              color: Colors.orange))
                    ]),
              )),
        ),
      ),
    );
  }
}
