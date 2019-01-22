import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailAndPassword(String email, String password);
  Future<String> register(String _email, String _password);
  Future<String> currentUser();
  Future<String> currentUserEmail();
  Future<void> changePassword(String email);
  Future<void> signOut();
  Future<String> getUser();
  Future<int> createUserInfo(Map map);
  Future<String> updateUserInfo(Map map);
  Future<int> isShop();
  Future<String> signInWithPhoneNumber(String phone, String password);

  void onLoginSucces(uid, email, password);

  Future<List> getDataFromURL_list(String url);
  Future<List> postDataFromURL_list(String url);
}

class Auth implements BaseAuth {
  final FirebaseAuth fb = FirebaseAuth.instance;
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      FirebaseUser user =
          await fb.signInWithEmailAndPassword(email: email, password: password);
      return user.uid;
    } catch (ex) {
      print(ex);
      return null;
    }
  }

  Future<String> register(String _email, String _password) async {
    FirebaseUser user;

    try {
      user = await fb.createUserWithEmailAndPassword(
          email: _email, password: _password);
      return user.uid;
    } catch (fb) {
      return null;
    }
  }

  Future<String> getUser() async {
    FirebaseUser user = await fb.currentUser();
    return user.displayName;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await fb.currentUser();
    isShop();
    if (user == null || user.uid == null) {
      return null;
    }
    return user.uid;
  }

  Future<String> currentUserEmail() async {
    FirebaseUser user = await fb.currentUser();

    return user.email;
  }

  Future<void> signOut() async {
    return fb.signOut();
  }

  Future<int> createUserInfo(Map map) async {
    var url = "http://192.168.100.2:8000/users/new/";
  }

  @override
  Future<int> isShop() async {
    // TODO: implement isAdmin
    String email = "Ss@gmail.com";

    var url = "http://192.168.100.2:8000/users/isshop/";
  }

  void storeToPreference(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
    print(await prefs.get(key));
  }

  @override
  void onLoginSucces(uid, email, password) {
    // TODO: implement onLoginSucces

    Map<String, dynamic> map = new Map<String, dynamic>();
    map["uid"] = uid;
    map["email"] = email;
    map["username"] = "@-";
    map["weight"] = 0.0;
    map["location"] = "Oman";
    map["tall"] = 150.0;
    createUserInfo(map);
  }

  @override
  Future<String> updateUserInfo(Map map) async {
    // TODO: implement updateUserInfo
    var url = "http://192.168.100.2:8000/users/update/20/";
  }

  @override
  Future<List> getDataFromURL_list(String url) async {
    // TODO: implement getDataFromURL_list
  }

  @override
  Future<List> postDataFromURL_list(String url) async {
    // TODO: implement postDataFromURL_list
  }

  @override
  Future<void> changePassword(String email) async {
    // TODO: implement changePassword
    await fb.sendPasswordResetEmail(email: email);
  }

  @override
  Future<String> signInWithPhoneNumber(String phone, String password) async {
    fb.verifyPhoneNumber(
        phoneNumber: "+96879163902",
        timeout: new Duration(minutes: 2),
        verificationCompleted: null,
        verificationFailed: null,
        codeSent: null,
        codeAutoRetrievalTimeout: null);
  }
}
