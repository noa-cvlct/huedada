import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hue_dada/home/model/home.dart';
import 'package:hue_dada/light/model/light.dart';
import 'package:hue_dada/room/model/room.dart';

class HomeRepository {
  final String homeCollection = 'homes';
  final String roomCollection = 'rooms';
  final String lightCollection = 'lights';

  CollectionReference getHomeCollection() =>
      FirebaseFirestore.instance.collection(homeCollection);

  DocumentReference getUserHomeDoc() =>
      getHomeCollection().doc(FirebaseAuth.instance.currentUser!.uid);

  Future<void> createUserHomeDoc(String name) async {
    await getUserHomeDoc().set(Home(name: name).toFirebase());
  }

  CollectionReference getUserRoomsCollection() =>
      getUserHomeDoc().collection(roomCollection);

  CollectionReference getUserRoomLightsCollection(String roomId) =>
      getUserRoomsCollection().doc(roomId).collection(lightCollection);

  Future<void> createRoom(String name, IconData icon) async {
    final doc = getUserRoomsCollection().doc();
    final room = Room(id: doc.id, name: name, icon: icon);
    await doc.set(room.toFirebase());
  }

  Future<void> deleteRoom(String roomId) async {
    await getUserRoomsCollection().doc(roomId).delete();
  }

  Future<void> createLight(
    String roomId,
    String name,
    IconData icon,
    LightType type,
  ) async {
    final doc = getUserRoomLightsCollection(roomId).doc();
    final light = Light(id: doc.id, name: name, icon: icon, type: type);
    await doc.set(light.toFirebase());
  }

  Future<void> switchHomeLightState(bool lightState) async {
    await getUserHomeDoc().update({
      'isOn': lightState,
    });
  }

  Future<void> switchRoomLightState(String roomId, bool lightState) async {
    await getUserRoomsCollection().doc(roomId).update({
      'isOn': lightState,
    });
  }

  Future<void> switchLightState(
    String roomId,
    String lightId,
    bool lightState,
  ) async {
    await getUserRoomLightsCollection(roomId).doc(lightId).update({
      'isOn': lightState,
    });
  }

  Future<void> switchLightColor(
    String roomId,
    String lightId,
    Color color,
  ) async {
    await getUserRoomLightsCollection(roomId).doc(lightId).update({
      'color': color.value,
    });
  }

  Future<void> changeRoomBrightness(String roomId, int brightness) async {
    await getUserRoomsCollection().doc(roomId).update({
      'brightness': brightness,
    });
  }

  Future<void> changeLightBrightness(
    String roomId,
    String lightId,
    int brightness,
  ) async {
    await getUserRoomLightsCollection(roomId).doc(lightId).update({
      'brightness': brightness,
    });
  }

  Future<void> changeLightSyncWithSound(
    String roomId,
    String lightId,
    bool syncWithSound,
  ) async {
    await getUserRoomLightsCollection(roomId).doc(lightId).update({
      'syncWithSound': syncWithSound,
    });
  }

  Future<void> deleteLight(String roomId, String lightId) async {
    await getUserRoomLightsCollection(roomId).doc(lightId).delete();
  }

  Stream<Home?> getUserHome() {
    return getUserHomeDoc().snapshots().map(
          (snapshot) => snapshot.exists
              ? Home.fromFirebase(
                  snapshot.id,
                  snapshot.data() as Map<String, dynamic>,
                )
              : null,
        );
  }

  Stream<List<Room>> getUserRooms() {
    return getUserRoomsCollection().snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Room.fromFirebase(
                    doc.id, doc.data() as Map<String, dynamic>),
              )
              .toList(),
        );
  }

  Stream<List<Light>> getUserRoomLights(String roomId) {
    return getUserRoomLightsCollection(roomId).snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Light.fromFirebase(
                    doc.id, doc.data() as Map<String, dynamic>),
              )
              .toList(),
        );
  }
}
