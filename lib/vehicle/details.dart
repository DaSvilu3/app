import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app/utils/auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:app/insurance/container.dart';

class CarInfo extends StatefulWidget {
  CarInfo(this.car);
  Map car;
  @override
  _CarInfo createState() => new _CarInfo();
}

class _CarInfo extends State<CarInfo> {
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
        title: new Text("Info"),
      ),
      backgroundColor: bgColor,
      body: new Container(
        width: MediaQuery.of(context).size.width,
        child: new SingleChildScrollView(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new SizedBox(height: 20.0,),
              new Container(
                child: new SvgPicture.network(widget.car["vendor"]["img"], height: 100.0,),
              ),
              new SizedBox(height: 20.0,),
              new Text("Vehicle Information", style: new TextStyle(fontWeight: FontWeight.w500, fontSize: 23),),
              new Container(
                width: MediaQuery.of(context).size.width - 30,
                child: new Card(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        margin: new EdgeInsets.all(10.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(" Model"),
                            new Text(widget.car["model"]["name"] + " ")
                          ],
                        ),
                      ),
                      new Divider(),
                      new Container(
                        margin: new EdgeInsets.all(10.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(" Make"),
                            new Text(widget.car["vendor"]["name"] + " ")
                          ],
                        ),
                      ),
                      new Divider(),
                      new Container(
                        margin: new EdgeInsets.all(10.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(" Type"),
                            new Text(widget.car["type"] + " ")
                          ],
                        ),
                      ),
                      new Divider(),
                      new Container(
                        margin: new EdgeInsets.all(10.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(" Vin No"),
                            new Text(widget.car["vin_ni"] + " ")
                          ],
                        ),
                      ),
                      new Divider(),
                      new Container(
                        margin: new EdgeInsets.all(10.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(" Year"),
                            new Text(widget.car["year"] + " ")
                          ],
                        ),
                      ),
                      new Divider(),
                      new Container(
                        margin: new EdgeInsets.all(10.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Text(" Engine Capacity"),
                            new Text(widget.car["engine"] + " ")
                          ],
                        ),
                      ),
                      new Divider(),

                    ],
                  ),
                ),

              ),
              new InkWell(
                  onTap: (){
                    navigateTo(ContainerInsurance(widget.car), false);
                  },
                  child: new Container(
                    margin: new EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(30.0),
                        color: themeColor
                    ),
                    height: 60.0,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Icon(MdiIcons.newBox, color: Colors.white, size: 30.0,),
                        new Text("Get Qoute", style: new TextStyle(fontSize: 20.0, color: Colors.white),)
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  void navigateTo(Widget widger, bool isfull) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => widger, fullscreenDialog: isfull));
  }
}
