import 'package:flutter/material.dart';

class ResetPass extends StatefulWidget {
  @override
  _ResetPass createState() => new _ResetPass();
}

class _ResetPass extends State<ResetPass> {
  bool isDone = false;
  TextEditingController emailAddress = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    
    Widget content ;
    if(isDone){
      content = new Container(
        width: MediaQuery.of(context).size.width,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[
            new SizedBox(height: 50.0,),
            new Container(
              width: MediaQuery.of(context).size.width - 40.0,
              child: new Card(
                elevation: 5.0,
                child: new Container(
                  padding: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 40.0),
                  child: new Column(
                    children: <Widget>[

                      new Icon(Icons.check_circle, color: Colors.green,),
                      new Text("Your new password has been sent to your email address " + emailAddress.text),

                    ],
                  ),
                ),
              ),
            ),
            new InkWell(//mazoonapp
              onTap: (){
                Navigator.of(context).pop();
              },
              child: new Container(
                margin: new EdgeInsets.only(top: 30.0),
                width: MediaQuery.of(context).size.width / 2.0,
                height: 60.0,
                decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(20.0),
                    color: Colors.red),
                child: new Center(
                  child: new Text(
                    "Back to Login",
                    style: new TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }else {
      content = new Container(
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new SizedBox(
                height: 40.0,
              ),
              new Text(
                "Welcome",
                style: new TextStyle(fontSize: 25.0, color: Colors.red),
                textAlign: TextAlign.start,
              ),
              new SizedBox(
                height: 19.0,
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
              new InkWell(
                onTap: (){
                  setState(() {
                    isDone = true;
                  });
                },
                child: new Container(
                  margin: new EdgeInsets.only(top: 30.0),
                  width: MediaQuery.of(context).size.width / 2.0,
                  height: 60.0,
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(20.0),
                      color: Colors.red),
                  child: new Center(
                    child: new Text(
                      "Get New Password",
                      style: new TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return new Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: new AppBar(
        title: new Text("Reset Password"),
      ),
      body: content
    );
  }
}
