import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:google_sign_in/google_sign_in.dart";


class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  User? _user;

  User? get user => _user;

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      _user = userCredential.user;

      // Check if the document with the user's UID already exists in the `users` collection
      final DocumentSnapshot docSnapshot = await _db.collection('users').doc(_user!.uid).get();
      if (!docSnapshot.exists) {
        // Update user details in Firestore database
        await _db.collection('users').doc(_user!.uid).set({
          'user_id': _user!.uid,
          'name': _user!.displayName,
          'email': _user!.email,
          'photoURL': _user!.photoURL,
          'sizz_coins': 0,
        });
      }

      notifyListeners();
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    _user = null;
    notifyListeners();
  }
}