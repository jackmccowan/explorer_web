import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; 
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithEmailAndPassword(
    String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

    Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password, String firstName, String lastName, String university) async {
      try {
        UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

        _fireStore.collection('users').doc(userCredential.user!.uid).set({
          'uid': userCredential.user!.uid,
          'email': email,
          'f_name': firstName,
          'l_name': lastName,
          'University': university,
          'createdAt': FieldValue.serverTimestamp(),
        });


        return userCredential;
        } on FirebaseAuthException catch (e) {
          throw Exception(e.code);
        }
      }
    

    Future<void> signOut() async {
      return await FirebaseAuth.instance.signOut();
    }
}