import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> addRoom(Room room) async {
    await getUserRoomsCollection().add(room.toFirebase());
  }

  Future<void> removeRoom(Room room) async {
    await getUserRoomsCollection().doc(room.id).delete();
  }

  Future<void> switchLightState(Home home, bool lightState) async {
    await getUserHome().update({
      'isOn': lightState,
    });
  }
}
