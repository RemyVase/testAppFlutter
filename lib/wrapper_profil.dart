

import 'package:chatouille/profil.dart';
import 'package:chatouille/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WrapperProfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        title: firebaseUser == null ? Text('Connexion') : Text('Profil'),
      ),
      body: firebaseUser == null ? SignIn() : Profil(),
    );
  }
}