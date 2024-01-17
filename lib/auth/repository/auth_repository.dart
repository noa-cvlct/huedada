import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hue_dada/home/model/home.dart';

class AuthRepository {
  final firestore = FirebaseFirestore.instance;

  final String userCollection = 'users';

  CollectionReference getUserCollection() =>
      firestore.collection(userCollection);

  DocumentReference getUser() =>
      getUserCollection().doc(FirebaseAuth.instance.currentUser!.uid);

  Future<void> createUserDocument() async {
    await getUser().set(const Home().toFirebase());
  }
}
