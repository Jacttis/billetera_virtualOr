import 'package:billetera_virtual/models/User.dart';
import 'package:billetera_virtual/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';


class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //create user obj on FirebaseUSer
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) :null;

  }

  //auth change user stream

  Stream<User> get user{
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }


  //sign in anon
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){

      print(e.toString());
      return null;
    }
  }


  //sign in with email & password
  Future signInWithEmailAndPassword(String email,String password)async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      DatabaseService.getInstance(user.uid);
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }

  //register with email & password
  Future registerWithEmailAndPassword(String email,String password,String moneda)async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      //create a new document for the user with the uid
      await DatabaseService.getInstance(user.uid).updateUserData(email, moneda);
      return _userFromFirebaseUser(user);
    }
    catch(e){
      return e.code;
    }

  }

  //sign out
  Future singOut() async{
    try{
      DatabaseService.SignOut();
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


}