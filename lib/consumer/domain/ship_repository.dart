import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ShipRepository {

  final FirebaseFirestore firebaseFirestore;

  ShipRepository({
    required this.firebaseFirestore,
  });

  Future<List<String>> getReservationsByUser(User? user) async {

    List<String> reservations = [];
    if (user == null) return reservations;
    var userData = firebaseFirestore.collection("user").doc(user.uid).get();
    await userData.then((e) {
      // TODO user reservations
      reservations = e.data()?['reservations'];
    });
    return reservations;
  }
}