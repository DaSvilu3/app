import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app/utils/auth.dart';

class SecondPage extends StatefulWidget {
  SecondPage(this.car);
  Map choice;
  Map car;
  @override
  _SecondPage createState() => new _SecondPage();
}

class _SecondPage extends State<SecondPage> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  Map userMap = null;
  Auth auth = new Auth();
  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

    //saveToGlobalVar();
  }

  getData() {
    auth.currentUser().then((uid) {
      if (uid != null) {
        print(uid);
        firebaseDatabase
            .reference()
            .child("users")
            .child(uid)
            .child("info")
            .once()
            .then((sn) {
          setState(() {
            userMap = sn.value;
          });
        });
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    DateTime dateTime = new DateTime.now( );
    return new Scaffold(

      body: Container(
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Text("Please choose one company"),
              new Card(
                child: new Column(
                  children: <Widget>[
                    new ListTile(
                      leading: new CircleAvatar(
                        child: new Text("Com"),
                        
                      ),
                      title: new Text("Company"),
                      subtitle: new Text("Best Company in the world"),
                      
                    ),
                    new Row(
                      children: <Widget>[
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Icon(Icons.location_on),
                            new Icon(Icons.call),
                            new Icon(Icons.web)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
