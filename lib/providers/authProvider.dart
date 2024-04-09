import "dart:convert";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/foundation.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:http/http.dart";
import "package:sizzlr_customer_side/constants/constants.dart";


class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  User? _user;

  User? get user => _user;

  Future<void> signInWithGoogle() async {
    print('Signing In...');
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    print('Google User: $googleUser');

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      _user = userCredential.user;

      signUpUserInDB();

      //
      // // Check if the document with the user's UID already exists in the `users` collection
      // final DocumentSnapshot docSnapshot = await _db.collection('users').doc(_user!.uid).get();
      // if (!docSnapshot.exists) {
      //   // Update user details in Firestore database
      //   await _db.collection('users').doc(_user!.uid).set({
      //     'user_id': _user!.uid,
      //     'name': _user!.displayName,
      //     'email': _user!.email,
      //     'photoURL': _user!.photoURL,
      //     'sizz_coins': 0,
      //   });
      // }

      notifyListeners();
    }
  }

  // Save user details in the database (New user)
  Future<void> signUpUserInDB() async {
    const String apiEndpoint = '$baseUrl/auth/signup';

    final Map<String, String> body = <String, String> {
      'name': _user!.displayName!,
      'email': _user!.email!,
      'contact': '0000000000',
      'password': 'Alohmora@20',
      'role': 'customer',
    };

    final Response response = await post(
      Uri.parse(apiEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      // Successfully signed up
      final responseJson = jsonDecode(response.body);
      if (kDebugMode) {
        print(responseJson);
      }
      return;
    }
  }

  Future<void> getCanteens() async {
    const String apiUrl = '$baseUrl/get-canteens';

    final Response response = await get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      if (kDebugMode) {
        print(responseJson);
      }
      return;
    } else {
      throw Exception('Failed to sign up: ${response.statusCode}: ${response.body}, ${response.request}, ${response.reasonPhrase}');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    _user = null;
    notifyListeners();
  }
}