import 'package:flutter/material.dart';
import 'signup.dart';
import 'resetpass.dart';
import '../widgets/clipp.dart';
import 'package:app/utils/auth.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<Login> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  BaseAuth auth = new Auth();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double height = MediaQuery.of(context).size.height;
    return new Scaffold(
      backgroundColor: Colors.grey[300],
      body: new Padding(
        padding: new EdgeInsets.all(10.0),
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new SizedBox(
                height: height * 0.15,
              ),
              new Text("Welcome", style: new TextStyle(fontSize: 25.0, color: Colors.red),),
              new SizedBox(
                height: 30.0,
              ),
              new Container(
                padding: new EdgeInsets.only(left: 5.0, top: 2.0, right: 20.0),
                margin: new EdgeInsets.symmetric(horizontal: 30.0),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(40.0)),
                child: new TextFormField(
                  controller: email,
                  decoration: new InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: "Email",
                    hintText: "email@email.com",
                    fillColor: Colors.white,
                  ),
                ),
              ),
              new SizedBox(
                height: 16.0,
              ),
              new Container(
                padding: new EdgeInsets.only(left: 5.0, top: 2.0, right: 20.0),
                margin: new EdgeInsets.symmetric(horizontal: 30.0),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(40.0)),
                child: new TextFormField(
                  controller: password,
                  obscureText: true,
                  decoration: new InputDecoration(
                    icon: Icon(Icons.security),
                    labelText: "Password",
                    hintText: "*******",
                    fillColor: Colors.white,
                  ),
                ),
              ),
              new Container(
                width: MediaQuery.of(context).size.width - 60.0,
                margin: new EdgeInsets.symmetric(vertical: 20.0),
                child: new InkWell(
                  onTap: () {
                    navigateTo(ResetPass());
                  },
                  child: new Text(
                    "Forget your password",
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              new InkWell(
                onTap: (){
                  auth.signInWithEmailAndPassword(email.text, password.text).then((uid){
                    print(uid);
                  });
                },
                child: new Container(
                  width: MediaQuery.of(context).size.width / 2.0,
                  height: 60.0,
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(20.0),
                      color: Colors.red),
                  child: new Center(
                    child: new Text(
                      "Sign in",
                      style: new TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              new Container(
                width: MediaQuery.of(context).size.width - 60.0,
                margin: new EdgeInsets.only(top: 40.0),
                child: new InkWell(
                  onTap: () {},
                  child: new Text(
                    "Don't have an account?",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      color: Colors.grey,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              new Container(
                width: MediaQuery.of(context).size.width - 60.0,
                margin: new EdgeInsets.only(top: 40.0),
                child: new InkWell(
                  onTap: () {
                    navigateTo(Signup());
                  },
                  child: new Text(
                    "SIGN UP NOW",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: Colors.red,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateTo(Widget widger){
    Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> widger,fullscreenDialog: true));
  }
}
