import 'package:firebase_auth/firebase_auth.dart';
import 'package:translator/translator.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signInWithEmailPassword({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      final translator = GoogleTranslator();
      var translation = await translator.translate(e.message, from: 'en', to: 'fr');
      print(translation.toString());
      return translation.toString();
    }
  }

  Future<String> signUpWithEmailPassword({String email, String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      final translator = GoogleTranslator();
      var translation = await translator.translate(e.message, from: 'en', to: 'fr');
      print(translation.toString());
      return translation.toString();
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    AccessToken accessToken = await FacebookAuth.instance.login().then((result) async {
      //print("accessToken : " + result.toJson().toString());
      // get the user data
      //final userData = await FacebookAuth.instance.getUserData();

      // Create a credential from the access token
      final FacebookAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.token);

      //print('FBCREDENTIAL : ' + facebookAuthCredential.toString());

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
