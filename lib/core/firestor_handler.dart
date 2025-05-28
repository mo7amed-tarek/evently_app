import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/users.dart';

class FirestorHandler {
  static CollectionReference<User> getUserCollection() {
    var collection = FirebaseFirestore.instance
        .collection("User")
        .withConverter(
          fromFirestore: (Snapshot, Options) {
            Map<String, dynamic>? data = Snapshot.data();
            return User.fromefirestor(data);
          },
          toFirestore: (user, options) {
            return user.tofirestor();
          },
        );
    return collection;
  }

  static Future<void> addUser(User user) {
    var collection = getUserCollection();
    var decument = collection.doc(user.id);
    return decument.set(user);
  }

  static Future<User?> getUser(String userId) async {
    var collection = getUserCollection();
    var decument = collection.doc(userId);
    var snapshot = await decument.get();
    return snapshot.data();
  }
}
