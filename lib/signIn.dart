import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'constants.dart';
import 'signUp.dart';
import 'authentication_service.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      decoration: InputDecoration(hintText: 'Email'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Veuillez entrer votre email';
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
                      decoration: InputDecoration(hintText: 'Mot de passe'),
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Veuillez entrer votre mot de passe';
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
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: ListTile(
                    title: RaisedButton(
                      color: kColor,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.red)),
                      onPressed: () {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
                          context.read<AuthenticationService>().signInWithEmailPassword(email: email, password: password).then((result) {
                            if (result != "Signed in") {
                              setState(() {
                                errorMessage = result;
                              });
                            }
                          });
                        }
                      },
                      child: Text("Se connecter"),
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
                        context.read<AuthenticationService>().signInWithFacebook();
                      },
                      child: Text("Facebook"),
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
                        context.read<AuthenticationService>().signInWithGoogle();
                      },
                      child: Text("Google"),
                    ),
                  ),
                ),
                errorMessage != "" ? Text(errorMessage) : Container(),
                new GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                    );
                  },
                  child: new Text("Pas encore inscrit ?", style: TextStyle(color: Colors.red[200])),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
