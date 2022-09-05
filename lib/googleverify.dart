import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class googleverify extends StatefulWidget {
  const googleverify({Key? key}) : super(key: key);

  @override
  State<googleverify> createState() => _googleverifyState();
}

class _googleverifyState extends State<googleverify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("google verify"),
      ),
      body: Column(
        children: [
          Center(
              child:
                  ElevatedButton(onPressed: () {
                    signInWithGoogle().then((value){
                      print(value);

                    });
                  }, child: Text("google verify"))),
          ElevatedButton(onPressed: () async {
            await GoogleSignIn().signOut().then((value) {
              print("logout");
            });
          }, child: Text("Sign out"))
        ],
      ),
    );
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
