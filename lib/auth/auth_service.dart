import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign out method
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
