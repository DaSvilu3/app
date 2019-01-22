import 'package:app/widgets/clipp.dart';

import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app/utils/auth.dart';
import 'package:app/vehicle/list.dart';

import 'view.dart';

class Profile extends StatefulWidget {
  @override
  _Profile createState() => new _Profile();
}

class _Profile extends State<Profile> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  Map userMap = null;
  Auth auth = new Auth();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
          print(sn.value);
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
    return new Container(
        color: bgColor,
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  new ClipPath(
                    clipper: new CustomShapeClipper(),
                    child: new Container(
                      height: 250.0,
                      decoration: new BoxDecoration(
                          gradient: new LinearGradient(colors: [
                        new Color(0xFF591946),
                        new Color(0xFF6B1A49),
                        new Color(0xFFAF1D55)
                      ])),
                    ),
                  ),
                  new Positioned(
                      bottom: 0,
                      left: 20.0,
                      right: 20.0,
                      height: 130.0,
                      child: new Card(
                        elevation: 10.0,
                        child: new Container(
                          padding: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15.0),
                          child: new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Container(
                                margin:
                                    new EdgeInsets.symmetric(horizontal: 10.0),
                                height: 60,
                                width: 60,
                                child: new CircleAvatar(
                                  backgroundColor: themeColor,
                                  child: new Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 25.0,
                                  ),
                                ),
                              ),
                              new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    userMap["first_name"] +
                                        " " +
                                        userMap["last_name"],
                                    style: new TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  new Text(userMap["age"] + " y",
                                      style: new TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
              new Container(
                margin: new EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width - 40.0,
                child: new Card(
                  child: new Container(
                    height: MediaQuery.of(context).size.width,
                    child: new GridView(
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      children: <Widget>[
                        new InkWell(
                          onTap: () {
                            navigateTo(new ViewProfile(), false);
                          },
                          child: new ItemCard(
                              "Personal\nInformation", Icons.contact_mail),
                        ),
                        new InkWell(
                          onTap: () {
                            navigateTo(new ListCars(), false);
                          },
                          child: new ItemCard(
                              "Vihicle \nDetails", Icons.directions_car),
                        ),
                        new InkWell(
                          onTap: () {},
                          child: new ItemCard("History", Icons.history),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void navigateTo(Widget widger, bool isfull) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => widger, fullscreenDialog: isfull));
  }
}

class ItemCard extends StatelessWidget {
  ItemCard(this.title, this.iconData);

  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      padding: new EdgeInsets.all(5.0),
      decoration: new BoxDecoration(
//                          color: Colors.red,
          borderRadius: new BorderRadius.circular(20.0)),
      child: new Card(
        elevation: 10.0,
        color: themeColor,
        child: new Container(
          padding: new EdgeInsets.symmetric(vertical: 5.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Icon(
                iconData,
                color: Colors.white,
                size: 50.0,
              ),
              new Text(
                title,
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
