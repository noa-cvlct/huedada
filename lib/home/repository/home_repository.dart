import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:hue_dada/home/model/home.dart';
import 'package:hue_dada/room/model/room.dart';

class HomeRepository {
  final String homeCollection = 'homes';
  final String roomCollection = 'rooms';

  CollectionReference getHomeCollection() =>
      FirebaseFirestore.instance.collection(homeCollection);

  DocumentReference getUserHome() =>
      getHomeCollection().doc(FirebaseAuth.instance.currentUser!.uid);

  Future<void> createUserDoc(String name) async {
    await getUserHome().set(Home(name: name).toFirebase());
  }

  CollectionReference getUserRoomsCollection() =>
      getUserHome().collection(roomCollection);

  Future<void> createRoom(String name, IconData iconData) async {
    final doc = getUserRoomsCollection().doc();
    final room = Room(id: doc.id, name: name, icon: iconData);
    await doc.set(room.toFirebase());
  }

  Future<void> removeRoom(Room room) async {
    await getUserRoomsCollection().doc(room.id).delete();
  }

  Future<void> switchLightState(bool lightState) async {
    await getUserHome().update({
      'isOn': lightState,
    });
  }
}
