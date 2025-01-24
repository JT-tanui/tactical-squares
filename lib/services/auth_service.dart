import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum UserTier { free, basic, premium }

class UserProfile {
  final String uid;
  final String name;
  final String country;
  final int rating;
  final UserTier tier;

  UserProfile({
    required this.uid,
    required this.name,
    required this.country,
    required this.rating,
    required this.tier,
  });

  factory UserProfile.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserProfile(
      uid: doc.id,
      name: data['name'] ?? 'Anonymous',
      country: data['country'] ?? 'Unknown',
      rating: data['rating'] ?? 1200,
      tier: UserTier.values[data['tier'] ?? 0],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'country': country,
      'rating': rating,
      'tier': tier.index,
    };
  }
}

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  Stream<User?> get user => _auth.authStateChanges();

  Future<UserProfile?> getUserProfile() async {
    if (currentUser != null) {
      DocumentSnapshot doc = await _firestore.collection('users').doc(currentUser!.uid).get();
      if (doc.exists) {
        return UserProfile.fromFirestore(doc);
      }
    }
    return null;
  }

  Future<UserCredential> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      await _loadUserProfile(result.user!);
      notifyListeners();
      return result;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<UserCredential> registerWithEmailAndPassword(String email, String password, String name, String country) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _createUserProfile(result.user!, name, country);
      notifyListeners();
      return result;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> _createUserProfile(User user, String name, String country) async {
    UserProfile profile = UserProfile(
      uid: user.uid,
      name: name,
      country: country,
      rating: 1200,
      tier: UserTier.free,
    );
    await _firestore.collection('users').doc(user.uid).set(profile.toFirestore());
  }

  Future<void> _loadUserProfile(User user) async {
    await getUserProfile();
  }

  Future<void> updateUserProfile(UserProfile updatedProfile) async {
    await _firestore.collection('users').doc(currentUser!.uid).update(updatedProfile.toFirestore());
    notifyListeners();
  }

  Future<void> upgradeTier(UserTier newTier) async {
    await _firestore.collection('users').doc(currentUser!.uid).update({'tier': newTier.index});
    notifyListeners();
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}

