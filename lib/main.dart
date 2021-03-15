import 'package:chatouille/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'conversations.dart';
import 'wrapper_profil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance)
        ),
        StreamProvider(create:(context) => context.read<AuthenticationService>().authStateChanges,)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chatouille',
        theme: ThemeData(
          primaryColor: kColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: menu(),
        body: TabBarView(
          children: [Conversations(), WrapperProfil()],
        ),
      ),
    );
  }
}

Widget menu() {
  return Material(
    elevation: 10.0,
    color: kColor,
    child: SafeArea(
      child: Container(
        color: kColor,
        child: TabBar(
          labelColor: Colors.white,
          indicatorColor: Colors.transparent,
          tabs: [
            Tab(icon: Icon(Icons.message_outlined)),
            Tab(icon: Icon(Icons.perm_identity_outlined)),
          ],
        ),
      ),
    ),
  );
}