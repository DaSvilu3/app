import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app/utils/auth.dart';
import 'cars_data.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddCar extends StatefulWidget {
  AddCar(this.voidCallback);
  VoidCallback voidCallback;
  @override
  _AddCar createState() => new _AddCar();
}

class _AddCar extends State<AddCar> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  Map userMap = null;
  Auth auth = new Auth();
  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey();
  String uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

    setState(() {
      choosedModel = cars[cars.length - 1];
    });
  }

  getData() {
    auth.currentUser().then((uid) {
      if (uid != null) {
        print(uid);
        setState(() {
          this.uid = uid;
        });
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

  final GlobalKey _menuKey = new GlobalKey();
  final GlobalKey _vendorKey = new GlobalKey();
  final GlobalKey _modelKey = new GlobalKey();
   String year = "2017";
  int vendor_choosen = 2;
  int car_type = 0;
  int engine_cap = 0;
  Map choosedModel = null;
  TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key: scaffoldState,
      appBar: new AppBar(
        title: new Text("Add Car"),
      ),
      backgroundColor: bgColor,
      body: new Container(
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new SizedBox(
                height: 32.0,
              ),
              new Container(
                padding: new EdgeInsets.all(10.0),
                child:
                new Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Column(
                        children: <Widget>[
                          new SizedBox(height: 10.0,),
                          new Text("Year"),
                          new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Text(year),
                              new PopupMenuButton(
                                onSelected: (s){

                                  setState(() {
                                    year = s.toString();
                                  });
                                },
                                key: _menuKey,
                                itemBuilder: (context) =>
                                <PopupMenuItem<String>>[]..addAll(buildYearList()),
                              )
                            ],
                          )
                        ],
                      ),
                      new Column(
                        children: <Widget>[
                          new SizedBox(height: 10.0,),

                          new Text("Vendor"),
                          new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Text(vendross[ vendor_choosen ]["name"]),
                              new PopupMenuButton(
                                onSelected: (s){

                                  setState(() {
                                    int ind = int.parse(s);
                                    vendor_choosen = ind-1;
                                    cars.forEach((c){
                                      if(c["vendor"] == ind) {
                                        choosedModel = c;
                                        return;
                                      }
                                    });
                                  });
                                },
                                key: _vendorKey,
                                itemBuilder: (context) =>
                                <PopupMenuItem<String>>[]..addAll(buildVendorList()),
                              )
                            ],
                          )
                        ],
                      ),new Column(
                        children: <Widget>[
                          new SizedBox(height: 10.0,),
                          new Text("Model"),
                          new Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              new Text(choosedModel["name"]),
                              new PopupMenuButton(
                                onSelected: (s){

                                  setState(() {
                                    choosedModel = cars[int.parse(s)];
                                  });
                                },
                                key: _modelKey,
                                itemBuilder: (context) =>
                                <PopupMenuItem<String>>[]..addAll(buildCarsList()),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),

                ),
              ),

              new Container(
                  padding: new EdgeInsets.all(10.0),
                child: new Card(
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Text("  Type Of Vehicle"),
                      new Container(
                        child: new Row(

                          children: <Widget>[
                            new Text(carsType[car_type]),
                            new PopupMenuButton(
                              onSelected: (s){

                                setState(() {
                                  car_type = int.parse(s);
                                });
                              },
                              //key: _modelKey,
                              itemBuilder: (context) =>
                              <PopupMenuItem<String>>[]..addAll(buildCarTypesList()),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ),
              new Container(
                  padding: new EdgeInsets.all(10.0),
                  child: new Card(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("  Engine Capacity"),
                        new Container(
                          child: new Row(

                            children: <Widget>[
                              new Text(engineCapacity[engine_cap].toString() + " L"),
                              new PopupMenuButton(
                                onSelected: (s){

                                  setState(() {
                                    engine_cap = int.parse(s);
                                  });
                                },
                                //key: _modelKey,
                                itemBuilder: (context) =>
                                <PopupMenuItem<String>>[]..addAll(buildCarCapacityList()),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
              ),
              new Padding(
                padding: new EdgeInsets.symmetric(
                    vertical: 5.0, horizontal: 10.0),
                child: new Card(
                  child: new Container(
                    child: new TextField(
                      controller: controller,
                      decoration: new InputDecoration(
                          hintText: "Vin No", labelText: "Vin No"),
                    ),
                    padding: new EdgeInsets.all(10.0),
                  ),
                ),
              ),
              new InkWell(
                onTap: (){
                  scaffoldState.currentState.showSnackBar(new SnackBar(
                    content: new Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                        new Text(" Adding: new vehicle")
                      ],
                    ),
                    duration: new Duration(seconds: 5),
                  ));


                  Map map = new Map.from({
                    "year" : year,
                    "vendor" : vendross[vendor_choosen],
                    "model"    : choosedModel,
                    "type"     : carsType[car_type],
                    "engine"   : engineCapacity[engine_cap].toString() + " L",
                    "vin_ni"   : controller.text + " - "
                  });
                  firebaseDatabase.reference().child("users").child(uid).child("cars").push().set(map).then((v){
                    widget.voidCallback();
                    Navigator.of(context).pop();
                  });

                },
                child: new Container(
                  margin: new EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(30.0),
                      color: themeColor
                  ),
                  height: 60.0,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Icon(MdiIcons.car, color: Colors.white, size: 30.0,),
                      new Text("Add new Vehicle", style: new TextStyle(fontSize: 20.0, color: Colors.white),)
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

  List<PopupMenuItem<String>> buildYearList() {
    List<PopupMenuItem<String>> list = [];

    for (int i = 2010; i < 2019; i++) {
      list.add(new PopupMenuItem<String>(
          child: new Text(i.toString()), value: i.toString()));
    }

    return list;
  }

  List<PopupMenuItem<String>> buildVendorList() {
    List<PopupMenuItem<String>> list = [];

    vendross.forEach((map){
      list.add(new PopupMenuItem<String>(
          child: new Text(map["name"]), value: map["id"].toString()));
    });


    return list;
  }

  List<PopupMenuItem<String>> buildCarsList() {
    List<PopupMenuItem<String>> list = [];

    for(int i=0 ; i < cars.length; i++){
      if(cars[i]["vendor"] == (vendor_choosen +1) ) {
        list.add(new PopupMenuItem<String>(
            child: new Text(cars[i]["name"]), value: i.toString()));
      }
    }



    return list;
  }

  List<PopupMenuItem<String>> buildCarTypesList() {
    List<PopupMenuItem<String>> list = [];

    for(int i=0 ; i < carsType.length; i++){

        list.add(new PopupMenuItem<String>(
            child: new Text(carsType[i]), value: i.toString()));

    }



    return list;
  }

  List<PopupMenuItem<String>> buildCarCapacityList() {
    List<PopupMenuItem<String>> list = [];

    for(int i=0 ; i < engineCapacity.length; i++){

      list.add(new PopupMenuItem<String>(
          child: new Text(engineCapacity[i].toString() + " L"), value: i.toString()));

    }



    return list;
  }




  void navigateTo(Widget widger, bool isfull) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => widger, fullscreenDialog: isfull));
  }
}
