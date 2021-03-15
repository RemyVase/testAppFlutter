import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Conversations extends StatefulWidget {
  @override
  _Conversations createState() => _Conversations();
}

class _Conversations extends State<Conversations> {
  
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        title: Text('Conversations'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            firebaseUser != null
            ?Text('Page Conversations de : ' + firebaseUser.email)
            :Text('Page Conversations')
          ],
        ),
      ),
    );
  }
}
