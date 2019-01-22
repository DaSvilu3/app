

import 'package:flutter/material.dart';

class Signup extends StatefulWidget {


  @override
  _Signup createState()=> new _Signup();
}

class _Signup extends State<Signup> {

  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController emailAddress = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController repassword = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController civilID = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Sign up"),
      ),
      body: new Container(
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Container(
//                padding: new EdgeInsets.only(left: 5.0, top: 2.0, right: 20.0),
                margin: new EdgeInsets.symmetric(horizontal: 30.0),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(40.0)),
                child: new TextFormField(
                  controller: firstName,
                  decoration: new InputDecoration(
                    labelText: "First Name",
                    hintText: "Mzoon, Ahmed, ... etc",
                    fillColor: Colors.white,
                  ),
                ),
              ),
              new SizedBox(
                height: 5.0,
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 30.0),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(40.0)),
                child: new TextFormField(
                  controller: lastName,
                  decoration: new InputDecoration(
                    labelText: "Last Name",
                    hintText: "Alfarsi ... etc",
                    fillColor: Colors.white,
                  ),
                ),
              ),
              new SizedBox(
                height: 5.0,
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 30.0),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(40.0)),
                child: new TextFormField(
                  controller: emailAddress,
                  decoration: new InputDecoration(
                    labelText: "Email",
                    hintText: "email@email.com",
                    fillColor: Colors.white,
                  ),
                ),
              ),
              new SizedBox(
                height: 5.0,
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 30.0),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(40.0)),
                child: new TextFormField(
                  controller: password,
                  decoration: new InputDecoration(
                    labelText: "password",
                    hintText: "*******",
                    fillColor: Colors.white,
                  ),
                ),
              ),
              new SizedBox(
                height: 5.0,
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 30.0),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(40.0)),
                child: new TextFormField(
                  controller: repassword,
                  decoration: new InputDecoration(
                    labelText: "Re-Password",
                    hintText: "*****",
                    fillColor: Colors.white,
                  ),
                ),
              ),
              new SizedBox(
                height: 4.0,
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 30.0),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(40.0)),
                child: new TextFormField(
                  controller: age,
                  decoration: new InputDecoration(
                    labelText: "Age",
                    hintText: "21,22,23",
                    fillColor: Colors.white,
                  ),
                ),
              ),
              new SizedBox(
                height: 4.0,
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 30.0),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(40.0)),
                child: new TextFormField(
                  controller: civilID,
                  obscureText: true,
                  decoration: new InputDecoration(
                    labelText: "Civil ID",
                    hintText: "12345678",
                    fillColor: Colors.white,
                  ),
                ),
              ),

              new Container(
                margin: new EdgeInsets.only(top: 30.0),
                width: MediaQuery.of(context).size.width / 2.0,
                height: 60.0,
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(20.0),
                    color: Colors.red),
                child: new Center(
                  child: new Text(
                    "Register",
                    style: new TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}