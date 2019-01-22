import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app/utils/auth.dart';

class Page extends StatefulWidget {
  @override
  _Page createState() => new _Page();
}

class _Page extends State<Page> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  Map userMap = null;
  Auth auth = new Auth();
  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey();

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
    return new Scaffold(
      key: scaffoldState,
      appBar: new AppBar(
        title: new Text("Page"),
      ),
      backgroundColor: bgColor,
    );
  }

  void navigateTo(Widget widger, bool isfull) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => widger, fullscreenDialog: isfull));
  }
}
