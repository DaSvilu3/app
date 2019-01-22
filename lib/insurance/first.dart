import 'package:flutter/material.dart';
import 'package:app/utils/theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:app/utils/auth.dart';

class FirstPage extends StatefulWidget {
  FirstPage(this.car);
  Map choice;
  Map car;
  @override
  _FirstPage createState() => new _FirstPage();
}

class _FirstPage extends State<FirstPage> {
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  Map userMap = null;
  Auth auth = new Auth();
  GlobalKey<ScaffoldState> scaffoldState = new GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    selectedDate = DateTime.parse("2015-01-18 00:00:00.000");
    controller = new TextEditingController(text: selectedDate.toLocal().toString().substring(0,11));
    saveToGlobalVar();
  }
  DateTime selectedDate = DateTime.parse("2015-01-18 00:00:00.000");
  TextEditingController controller = new TextEditingController();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        
        initialDate: selectedDate,
        firstDate: DateTime(2014, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        print(picked);
        selectedDate = picked;
        controller = new TextEditingController(text: picked.toLocal().toString().substring(0,11));
        saveToGlobalVar();
      });
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

  double _result = 0.0;
  int _radioValue = 1;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:

      break;
    }
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    DateTime dateTime= new DateTime.now();

    int year = dateTime.difference(selectedDate).inDays;
    print(year/365) ;
    double resultPrice = double.parse(widget.car["model"]["price"].toString())  * year / 365* 0.05;
    print(resultPrice);
    return new Scaffold(
      key: scaffoldState,
      backgroundColor: Colors.white,
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        child:  new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("First date of issued licence:"),
            new TextField(
              controller: controller,
              onChanged: (c){
                print(c);
                saveToGlobalVar();
              },
            ),
            //Text("${selectedDate.toLocal().toString().substring(0,11)}"),
            SizedBox(height: 20.0,),
            new Center(
              child: RaisedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select date'),
              ),
            ),

            SizedBox(height: 20.0,),
            new Text("Type Of Insurance: "),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                new Radio(
                  value: 1,
                  activeColor: themeColor,
                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                new Text('Comprehensive'),
                new Radio(
                  value: 2,
                  activeColor: themeColor,

                  groupValue: _radioValue,
                  onChanged: _handleRadioValueChange,
                ),
                new Text('third party'),
              ],
            ),
        (_radioValue == 1 ?

            new Column(
              children: <Widget>[
                new Card(
                  child: new ListTile(
                    title: new Text("Original Price of Vehicle: "),
                    trailing: new Text(widget.car["model"]["price"].toString() + " RO"),
                  )
                ),
                new Card(
                    child: new ListTile(
                      title: new Text("Current Price of Vehicle: "),

                      trailing: new Text(double.parse((widget.car["model"]["price"] - resultPrice).toString()).toStringAsFixed(1) + " RO"),
                    )
                ),
              ],
            )
            : new Container())
          ],
        ),
      )

    );
  }

  void saveToGlobalVar(){
    setState(() {
      DateTime dateTime= new DateTime.now();

      int year = dateTime.difference(selectedDate).inDays;
      Map map = new Map();
      map["first_issued_date"] = selectedDate.toLocal().toString().substring(0,11);
      map["type"] = _radioValue;
      map["original"] = widget.car["model"]["price"].toString() + " RO";
      double resultPrice = double.parse(widget.car["model"]["price"].toString())  * year / 365* 0.05;
      map["current"]  = double.parse((widget.car["model"]["price"] - resultPrice).toString()).toStringAsFixed(1);
      widget.choice = map;

    });
  }
  void navigateTo(Widget widger, bool isfull) {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => widger, fullscreenDialog: isfull));
  }
}
