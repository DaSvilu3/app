import 'package:app/widgets/clipp.dart';

import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app/utils/auth.dart';
import 'package:share/share.dart';
import 'edit.dart';

class ViewProfile extends StatefulWidget {
  @override
  _ViewProfile createState() => new _ViewProfile();
}

class _ViewProfile extends State<ViewProfile> {
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
    setState(() {
      userMap = null;
    });
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
            print(sn.value);
            userMap = sn.value;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Information"),
      ),
      backgroundColor: bgColor,
      body: (userMap == null
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : new Container(
              child: new SingleChildScrollView(
                  child: new Column(
                children: <Widget>[
                  new SizedBox(
                    height: 20.0,
                  ),
                  new Padding(
                    padding: new EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    child: new Card(
                      child: new Container(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(
                              "Email Address",
                              textAlign: TextAlign.start,
                              style: new TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                            new Text(
                              userMap["email"],
                              style: new TextStyle(color: themeColor),
                            ),
                          ],
                        ),
                        padding: new EdgeInsets.all(10.0),
                        margin: new EdgeInsets.symmetric(vertical: 10.0),
                      ),
                    ),
                  ),
                  new Container(
                    padding: new EdgeInsets.symmetric(horizontal: 10.0),
                    child: new Card(
                      child: new Container(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(
                              "Name",
                              textAlign: TextAlign.start,
                              style: new TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                            new Text(
                              userMap["first_name"] +
                                  " " +
                                  userMap["last_name"],
                              style: new TextStyle(color: themeColor),
                            ),
                          ],
                        ),
                        padding: new EdgeInsets.all(10.0),
                        margin: new EdgeInsets.symmetric(vertical: 10.0),
                      ),
                    ),
                  ),
                  new Container(
                    padding: new EdgeInsets.symmetric(horizontal: 10.0),
                    child: new Card(
                      child: new Container(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(
                              "Age",
                              textAlign: TextAlign.start,
                              style: new TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                            new Text(
                              userMap["age"],
                              style: new TextStyle(color: themeColor),
                            ),
                          ],
                        ),
                        padding: new EdgeInsets.all(10.0),
                        margin: new EdgeInsets.symmetric(vertical: 10.0),
                      ),
                    ),
                  ),
                  new Container(
                    padding: new EdgeInsets.symmetric(horizontal: 10.0),
                    child: new Card(
                      child: new Container(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(
                              "Civil ID",
                              textAlign: TextAlign.start,
                              style: new TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                            new Text(
                              userMap["civilID"],
                              style: new TextStyle(color: themeColor),
                            ),
                          ],
                        ),
                        padding: new EdgeInsets.all(10.0),
                        margin: new EdgeInsets.symmetric(vertical: 10.0),
                      ),
                    ),
                  ),
                  new Container(
                    padding: new EdgeInsets.symmetric(horizontal: 10.0),
                    child: new Card(
                      child: new Container(
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(
                              "Phone Number",
                              textAlign: TextAlign.start,
                              style: new TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300),
                            ),
                            new Text(
                              userMap["phone"].toString(),
                              style: new TextStyle(color: themeColor),
                            ),
                          ],
                        ),
                        padding: new EdgeInsets.all(10.0),
                        margin: new EdgeInsets.symmetric(vertical: 10.0),
                      ),
                    ),
                  ),
                  new SizedBox(
                    height: 32.0,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new InkWell(
                        onTap: () {
                          navigateTo(
                              new EditProfile(
                                voidCallback: getData,
                              ),
                              false);
                        },
                        child: new Container(
                          padding: new EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width / 2,
                          child: new ItemCard("Edit Info\n", Icons.settings),
                        ),
                      ),
                      new InkWell(
                        onTap: () {
                          String sharedText = "";
                          sharedText += "Hi! My name is " +
                              userMap["first_name"] +
                              " " +
                              userMap["last_name"] +
                              " !";
                          sharedText += "\n";
                          sharedText += "I'm " +
                              userMap["age"].toString() +
                              " years old. My contact ways are email & phone number";
                          sharedText += "\n";
                          sharedText += "Email: " +
                              userMap["email"] +
                              " - Phone Number: " +
                              userMap["phone"].toString();
                          Share.share(sharedText);
                        },
                        child: new Container(
                          padding: new EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width / 2,
                          child: new ItemCard("Share Info\n", Icons.share),
                        ),
                      )
                    ],
                  )
                ],
              )),
            )),
    );
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
