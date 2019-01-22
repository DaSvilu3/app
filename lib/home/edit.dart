import 'package:app/widgets/clipp.dart';

import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app/utils/auth.dart';
import 'package:share/share.dart';

class EditProfile extends StatefulWidget {
  EditProfile({this.voidCallback});
  final VoidCallback voidCallback;
  @override
  _EditProfile createState() => new _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  Map userMap = null;
  Auth auth = new Auth();

  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey();

  TextEditingController firstName;
  TextEditingController lastName;
  TextEditingController birthDay;
  TextEditingController phone;
  TextEditingController civilId;
  String uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    auth.currentUser().then((uid) {
      if (uid != null) {
        setState(() {
          this.uid = uid;
        });
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
            initEditTextController();
          });
        });
      }
    });
  }

  void initEditTextController() {
    setState(() {
      firstName = new TextEditingController(text: userMap["first_name"]);
      lastName = new TextEditingController(text: userMap["last_name"]);
      birthDay = new TextEditingController(text: userMap["age"]);
      civilId = new TextEditingController(text: userMap["civilID"]);
      phone = new TextEditingController(text: userMap["phone"].toString());
    });
  }

  void clearEditTextController() {
    setState(() {
      firstName = new TextEditingController();
      lastName = new TextEditingController();
      birthDay = new TextEditingController();
      civilId = new TextEditingController();
      phone = new TextEditingController();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key: scaffoldState,
      appBar: new AppBar(
        title: new Text("Edit Information"),
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
                        child: new TextField(
                          controller: firstName,
                          decoration: new InputDecoration(
                              hintText: "First Name", labelText: "First Name"),
                        ),
                        padding: new EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    child: new Card(
                      child: new Container(
                        child: new TextField(
                          controller: lastName,
                          decoration: new InputDecoration(
                              hintText: "Last Name", labelText: "Last Name"),
                        ),
                        padding: new EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    child: new Card(
                      child: new Container(
                        child: new TextField(
                          controller: birthDay,
                          decoration: new InputDecoration(
                              hintText: "Date of Birth",
                              labelText: "Date of Birth"),
                        ),
                        padding: new EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    child: new Card(
                      child: new Container(
                        child: new TextField(
                          controller: civilId,
                          decoration: new InputDecoration(
                              hintText: "Civil ID", labelText: "Civil ID"),
                        ),
                        padding: new EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 10.0),
                    child: new Card(
                      child: new Container(
                        child: new TextField(
                          controller: phone,
                          decoration: new InputDecoration(
                              hintText: "Phone", labelText: "Phone"),
                        ),
                        padding: new EdgeInsets.all(10.0),
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
                          clearEditTextController();
                        },
                        child: new Container(
                          padding: new EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width / 2,
                          child: new ItemCard(
                              "Reset All\n", Icons.clear_all, Colors.blueGrey),
                        ),
                      ),
                      new InkWell(
                        onTap: () {
                          saveInfo();
                        },
                        child: new Container(
                          padding: new EdgeInsets.all(10.0),
                          width: MediaQuery.of(context).size.width / 2,
                          child: new ItemCard(
                              "Save Info\n", Icons.check, themeColor),
                        ),
                      )
                    ],
                  )
                ],
              )),
            )),
    );
  }

  void saveInfo() {
    if (firstName.text != "" && firstName.text != " " &&
        lastName.text != "" &&
        birthDay.text != "" &&
        civilId.text != "" &&
        phone.text != "") {
      print("correct");
      scaffoldState.currentState.showSnackBar(new SnackBar(
        content: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Icon(
              Icons.cached,
              color: Colors.green,
            ),
            new Text(" Updating: Personal Information")
          ],
        ),
        duration: new Duration(seconds: 5),
      ));

      Map val = new Map.from({
        "first_name": firstName.text,
        "last_name": lastName.text,
        "age": birthDay.text.toString(),
        "civilID": civilId.text,
        "phone": phone.text.toString(),
        "email": userMap["email"]
      });
      firebaseDatabase
          .reference()
          .child("users")
          .child(uid)
          .child("info")
          .set(val)
          .then((c) {
        widget.voidCallback();
        Navigator.of(context).pop();
      });
    } else {
      scaffoldState.currentState.showSnackBar(
          new SnackBar(content: new Text("Please fill Information")));
    }
  }
}

class ItemCard extends StatelessWidget {
  ItemCard(this.title, this.iconData, this.color);

  final String title;
  final IconData iconData;
  Color color;

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
        color: color,
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
