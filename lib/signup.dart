import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _form1Key = GlobalKey<FormState>();
  final myController2 = TextEditingController();
  final myController1 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();
  final myController6 = TextEditingController();

  bool _secureText = true;

  void toggle() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  void dispose() {
    super.dispose();
    myController2.dispose();
    myController1.dispose();
    myController3.dispose();
    myController4.dispose();
    myController5.dispose();
    myController6.dispose();
  }

  storeLocal() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences store = await SharedPreferences.getInstance();
    store.setBool('verifyUser', true);
    await store.setString("user", myController1.text);
    await store.setString("pass", myController2.text);
    store.setString("phn", myController3.text);
    store.setString("email", myController4.text);
    if (myController5.text != null) {
      store.setString("clg", myController5.text);
    }
    if (myController6.text != null) {
      store.setString("linkedln", myController6.text);
    }
  }

  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Form(
              key: _form1Key,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    controller: myController1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Enter your Name";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      border: const OutlineInputBorder(),
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.person_pin)),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    controller: myController3,
                    keyboardType: TextInputType.number,
                    validator: (value) =>
                        value.length != 10 ? "Enter 10 digits only" : null,
                    decoration: InputDecoration(
                      hintText: "Enter Contact Number",
                      border: const OutlineInputBorder(),
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.call)),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: myController4,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty)
                        return "Enter Email ID";
                      else
                        return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Email",
                      border: const OutlineInputBorder(),
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.email)),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: myController5,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Enter College Name",
                      border: const OutlineInputBorder(),
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.school)),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: myController6,
                    keyboardType: TextInputType.url,
                    decoration: InputDecoration(
                      hintText: "Enter Linkedln ID",
                      border: const OutlineInputBorder(),
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.link)),
                    ),
                  ),
                  SizedBox(height: 40.0),
                  TextFormField(
                    controller: myController2,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      border: const OutlineInputBorder(),
                      icon: const Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: const Icon(Icons.remove_red_eye)),
                    ),
                    validator: (value) =>
                        value.length < 6 ? 'Password too short.' : null,
                    obscureText: _secureText,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: RaisedButton(
                      elevation: 70.0,
                      highlightElevation: 110.0,
                      shape: StadiumBorder(),
                      padding: EdgeInsets.all(20.0),
                      focusElevation: 40.0,
                      onPressed: () async {
                        if (_form1Key.currentState.validate()) {
                          await storeLocal();
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.pushNamed(context, "first");
                        }
                      },
                      child: _isLoading
                          ? CircularProgressIndicator()
                          : Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 20.0),
                            ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
