import 'package:flutter/material.dart';
import 'widgets/clipp.dart';
import 'account/login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Login(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        color: Colors.white,
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
                        new Color.fromRGBO(81, 15, 56, 1.0),
                        new Color.fromRGBO(155, 7, 67, 1.0)
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

                      padding: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                      child: new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Container(
                              margin: new EdgeInsets.symmetric(horizontal: 10.0),
                              height: 60,
                              width: 60,
                              child: new CircleAvatar(
                                backgroundColor: Colors.grey[600],
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
                                new Text("Hello, Afraa", style: new TextStyle(color: Colors.grey[600], fontSize: 20.0, fontWeight: FontWeight.bold),),
                                new Text("Welcome To Aman App", style: new TextStyle(color: Colors.grey,fontWeight: FontWeight.bold))
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
                child: new Column(
                  children: <Widget>[
                    new Text("ddd")
                  ],
                ),
              ),
              )
            ]
            ,
          ),
        ));
  }
}
