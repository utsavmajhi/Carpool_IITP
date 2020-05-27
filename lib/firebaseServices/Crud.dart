import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class crudMethods{
  getData(String uid) async{
    return await Firestore.instance.collection("UsersData").document(uid).get();
  }
}