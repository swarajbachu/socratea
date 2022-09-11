import 'package:flutter/material.dart';

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:socratea/models/user_details.dart';
import 'package:socratea/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<String> saveUserDetails(String grade, String uid,
      String gender,String school, String education,String roll,String state) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String userId = const Uuid().v1(); // creates unique id based on time
      UserDetails _userDetails = UserDetails(
        grade: grade,
        uid: uid,
        gender: gender,
        userId: userId,
        school: school,
        education: education,
        rollNo: roll,
        state: state,
      );
      _firestore.collection('userDetails').doc(userId).set(_userDetails.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> updateUserDetails(String grade, String uid,
      String gender,String school, String education,String roll,String state) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String userId = const Uuid().v1(); // creates unique id based on time
      UserDetails post = UserDetails(
        grade: grade,
        uid: uid,
        gender: gender,
        school: school,
        userId: userId,
        education: education,
        rollNo: roll,
        state: state,
      );
      _firestore.collection('userDetails').doc(userId).update(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }




  Future<void> followUser(
      String uid,
      String followId
      ) async {
    try {
      DocumentSnapshot snap = await _firestore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if(following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }

    } catch(e) {
      print(e.toString());
    }
  }
}
