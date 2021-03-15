import 'package:chatouille/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class Profil extends StatefulWidget {
  @override
  _Profil createState() => _Profil();
}

class _Profil extends State<Profil> {
  User user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Text('Connecté sur : ${user.email}'),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: ListTile(
              title: RaisedButton(
                color: kColor,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.red)),
                onPressed: () {
                  signOut();
                },
                child: Text("Se déconnecter"),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
