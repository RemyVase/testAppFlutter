import 'package:chatouille/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUp createState() => _SignUp();
}

class _SignUp extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String pseudo;
  String email;
  String password;
  String passwordConfirm;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        title: Text('Inscription'),
      ),
      body: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: ListTile(
                      leading: const Icon(Icons.person),
                      title: TextFormField(
                        decoration: InputDecoration(hintText: 'Pseudo'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Veuillez entrer un pseudo';
                          }
                          return null;
                        },
                        onChanged: ((value) {
                          setState(() {
                            pseudo = value;
                          });
                        }),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: ListTile(
                      leading: const Icon(Icons.alternate_email),
                      title: TextFormField(
                        decoration: InputDecoration(hintText: 'Email'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Veuillez entrer un email';
                          } else if (!EmailValidator.validate(value)) {
                            return 'Veuillez entrer un email valide';
                          }
                          return null;
                        },
                        onChanged: ((value) {
                          setState(() {
                            email = value;
                          });
                        }),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: ListTile(
                      leading: const Icon(Icons.lock),
                      title: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'Mot de passe'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Veuillez entrer un mot de passe';
                          }
                          return null;
                        },
                        onChanged: ((value) {
                          setState(() {
                            password = value;
                          });
                        }),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: ListTile(
                      leading: const Icon(Icons.lock),
                      title: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(hintText: 'Confirmation de mot de passe'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Veuillez entrer un mot de passe';
                          }
                          if (passwordConfirm != password) {
                            return "Mot de passe non identique";
                          }
                          return null;
                        },
                        onChanged: ((value) {
                          setState(() {
                            passwordConfirm = value;
                          });
                        }),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ListTile(
                      title: RaisedButton(
                        color: kColor,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.red)),
                        onPressed: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState.validate()) {
                            context.read<AuthenticationService>().signUpWithEmailPassword(email: email, password: password).then((result) {
                              if (result != "Signed up") {
                                setState(() {
                                  errorMessage = result;
                                });
                              } else {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      child: Text('Inscription réussie !'),
                                    );
                                  },
                                );
                              }
                            });
                          }
                        },
                        child: Text("S'inscrire"),
                      ),
                    ),
                  ),
                  errorMessage != "" ? Text(errorMessage) : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
