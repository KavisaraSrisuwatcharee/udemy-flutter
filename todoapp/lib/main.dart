import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      builder: (context, _) => Consumer<AppState>(
          builder: (ctx, auth, _) => MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.teal.shade300,
              ),
              home: auth.credentials != null ? BlankPage() : MyHomePage())),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOGIN',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.normal)),
        toolbarHeight: 30,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Chingly's Todo",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Just a to do app of Chingly",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 240,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 240,
                  child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF4DB6AC)),
                  ),
                  onPressed: () {
                    Provider.of<AppState>(context, listen: false)
                        .login(emailController.text, passwordController.text);
                    // await Firebase.initializeApp(
                    //   FirebaseAuth.instance.userChanges()
                    // );
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  var credentials;
  AppState() {
    init();
  }
  void login(email, password) async {
    //no account
    try {
      var status =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (!status.contains('password')) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } else {
        try {
          await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password);
        } on FirebaseAuthException catch (_) {}
      }
    } on FirebaseAuthException catch (_) {}
    notifyListeners();
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

  Future<void> init() async {
    await Firebase.initializeApp();
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        credentials = user.email;
      } else {
        credentials = null;
      }
      notifyListeners();
    });
  }
}

class BlankPage extends StatelessWidget {
  const BlankPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF4DB6AC)),
                  ),
                  onPressed: () {
                    Provider.of<AppState>(context, listen: false).logout();
                  },
                  child: Text(
                    'LOGOUT',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        ],
      ),
    ));
  }
}
