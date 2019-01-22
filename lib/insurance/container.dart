import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app/utils/auth.dart';
import 'first.dart';
import 'second.dart';

class ContainerInsurance extends StatefulWidget {
  ContainerInsurance(this.car);
  Map car;
  @override
  _ContainerInsurance createState() => new _ContainerInsurance();
}

class _ContainerInsurance extends State<ContainerInsurance> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  Map userMap = null;
  Auth auth = new Auth();
  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    listOfWidgets = [
      new FirstPage(widget.car),
      new SecondPage(widget.car),
      new FirstPage(widget.car),
      new FirstPage(widget.car),
      new FirstPage(widget.car)
    ];
  }

  List<Widget> listOfWidgets = [];
  int choosedWidget = 0;

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return new Scaffold(
      key: scaffoldState,
      appBar: new AppBar(
        title: new Text("Get Qoute"),
        
      ),
      backgroundColor: bgColor,
      floatingActionButton: new FloatingActionButton(onPressed: (){
        setState(() {
          if(choosedWidget >= listOfWidgets.length - 1){
            choosedWidget = 0;
          }else {
            choosedWidget +=1 ;
          }
        });
      }, child: new Icon(Icons.chevron_right), backgroundColor: themeColor,),
      body: new Container(
        child: new SingleChildScrollView(
          child: new Column(
            children: <Widget>[
              new Container(
                height: height * 0.1,
                child: new Card(
                  child: new ListView.builder(itemBuilder: (context, index) {
                    return new InkWell(
                      onTap: (){
                        setState(() {
                          choosedWidget = index;
                        });
                      },
                      child: new Container(
                        width: width /6 - 10.0,
                        margin: new EdgeInsets.all(10.0),
                        child: new CircleAvatar(
                          backgroundColor: index > choosedWidget ? Colors.grey: themeColor,
                          foregroundColor: Colors.white,
                          child: new Text((index + 1).toString()),
                        ),
                      ),

                    );
                  },
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,),
                  
                ),
              ),
              new Container(
                height: height * 0.8,
                child: new Card(
                  child: listOfWidgets[choosedWidget],
                ),
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
