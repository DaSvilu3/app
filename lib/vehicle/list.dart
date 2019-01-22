import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app/utils/auth.dart';
import 'add.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'details.dart';

class ListCars extends StatefulWidget {
  @override
  _ListCars createState() => new _ListCars();
}

class _ListCars extends State<ListCars> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  Map userMap = null;
  Auth auth = new Auth();
  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey();

  List car_list = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    setState(() {
      car_list = [];
      isLoading = true;
    });
    auth.currentUser().then((uid) {
      if (uid != null) {
        print(uid);
        firebaseDatabase
            .reference()
            .child("users")
            .child(uid)
            .child("cars")
            .once()
            .then((sn) {
          setState(() {
            isLoading = false;
            Map map = sn.value;
            print(map.keys.runtimeType);
            map.keys.forEach((ke) {
              car_list.add(map[ke.toString()]);
            });
          });

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    Widget content ;

    if(isLoading) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    }
    else if(car_list.length == 0){
      content = new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("You didn't add any vehicles yet, Add new ?"),
            new InkWell(
              onTap: (){
                navigateTo(AddCar(getData), true);
              },
              child: new Icon(
                Icons.add_circle,
                color: themeColor,
                size: 70.0,
              ),
            )
          ],
        ),
      );
    }else {
      content = buildListOfCars();
    }
    return new Scaffold(
      key: scaffoldState,
      appBar: new AppBar(
        title: new Text("List Of Vehicles"),
      ),
      backgroundColor: bgColor,
      body: new Container(
        child: content
      ),
      floatingActionButton: car_list.length == 0 ? new Container() : new FloatingActionButton(onPressed: (){
        navigateTo(new AddCar(getData), true);
      },backgroundColor: themeColor, child: new Icon(
        Icons.add,
      ),),
    );
  }


  Widget buildListOfCars(){

    List<Widget> list = [];
    list.add(new SizedBox(height: 16.0,));


    car_list.forEach((tile){
      if(tile == null) return;
      
      list.add(new Card(
        child: new ListTile(
          onTap: (){
            navigateTo(new CarInfo(tile), false);
          },
          leading: new Container(
            width: 50.0,
            height: 50.0,
            child: new CircleAvatar(
              backgroundColor: themeColor,
              child: new SvgPicture.network(tile["vendor"]["img"], width: 40.0,),
            ),
          ),
          title: new Text(  tile["model"]["name"]),
          subtitle: new Text( tile["vendor"]["name"] + ", " + tile["year"] + ", Vin No: "+ tile["vin_ni"].toString().replaceAll("-", " ")),
        ),
      ));
      list.add(new Divider(height: 2,));
    });
    
    return new ListView(
      children: <Widget>[]..addAll(list),
    );
  }

  void navigateTo(Widget widger, bool isfull) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => widger, fullscreenDialog: isfull));
  }
}
