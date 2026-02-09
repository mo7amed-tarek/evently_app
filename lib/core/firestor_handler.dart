import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/model/users.dart' as MyUser;

class FirestorHandler {
  static CollectionReference<MyUser.User> getUserCollection() {
    return FirebaseFirestore.instance
        .collection('User')
        .withConverter<MyUser.User>(
          fromFirestore: (snap, _) => MyUser.User.fromefirestor(snap.data()),
          toFirestore: (user, _) => user.tofirestor(),
        );
  }

  static Future<void> addUser(MyUser.User user) {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser.User?> getUser(String uid) async {
    final snap = await getUserCollection().doc(uid).get();
    if (!snap.exists || snap.data() == null) return null;
    return snap.data();
  }

  static Stream<MyUser.User?> streamUser(String uid) {
    return getUserCollection().doc(uid).snapshots().map((snap) => snap.data());
  }

  static Stream<List<MyUser.User>> streamAllUsers() {
    return getUserCollection().snapshots().map(
      (snap) => snap.docs.map((e) => e.data()).toList(),
    );
  }

  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection('Events')
        .withConverter<Event>(
          fromFirestore: (snap, _) => Event.fromFireStore(snap.data(), snap.id),
          toFirestore: (event, _) => event.toFirestore(),
        );
  }

  static Future<void> addEvent(Event event) async {
    final doc = getEventCollection().doc();
    event.id = doc.id;
    await doc.set(event);
  }

  static Future<List<Event>> getEventsByType(String type) async {
    final col = getEventCollection();
    final snap =
        type.toLowerCase() == 'all'
            ? await col.get()
            : await col.where('type', isEqualTo: type).get();
    return snap.docs.map((e) => e.data()).toList();
  }

  static Stream<List<Event>> streamEventsByType(String type) {
    final col = getEventCollection();
    final query =
        type.toLowerCase() == 'all' ? col : col.where('type', isEqualTo: type);
    return query.snapshots().map(
      (snap) => snap.docs.map((e) => e.data()).toList(),
    );
  }

  static Stream<List<Event>> streamAllEventsSorted() {
    return getEventCollection()
        .orderBy('date', descending: false)
        .snapshots()
        .map((snap) => snap.docs.map((e) => e.data()).toList());
  }

  static Future<void> updateEvent(Event event) {
    return getEventCollection().doc(event.id).update(event.toFirestore());
  }

  static Future<void> deleteEvent(String eventId) {
    return getEventCollection().doc(eventId).delete();
  }

  static CollectionReference<Event> getwishListCollection(String userId) {
    return getUserCollection()
        .doc(userId)
        .collection('wishlist')
        .withConverter<Event>(
          fromFirestore: (snap, _) => Event.fromFireStore(snap.data(), snap.id),
          toFirestore: (event, _) => event.toFirestore(),
        );
  }

  static Future<void> addfavoriteEvent(String userId, Event event) {
    return getwishListCollection(userId).doc(event.id).set(event);
  }

  static Future<void> removefavoriteEvent(String userId, Event event) {
    return getwishListCollection(userId).doc(event.id).delete();
  }

  static Stream<List<Event>> getWishListStream(String userId) {
    return getwishListCollection(userId)
        .orderBy('date', descending: false)
        .snapshots()
        .map((snap) => snap.docs.map((e) => e.data()).toList());
  }

  static Future<void> updateEventFavorite(Event event) {
    return getEventCollection().doc(event.id).update({
      "favoriteUsers": event.favoriteUsers,
    });
  }
}
