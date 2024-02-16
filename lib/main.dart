import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hands_on/firebase_options.dart';

void main() {
  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Firebase Registration.'),
        ),
        body: FutureBuilder(
          future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Column(
                  children: [
                    TextField(
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      enableSuggestions: true,
                      controller: _email,
                      decoration:
                          const InputDecoration.collapsed(hintText: 'Email'),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      obscureText: true,
                      enableSuggestions: true,
                      autocorrect: false,
                      controller: _password,
                      decoration:
                          const InputDecoration.collapsed(hintText: 'Password'),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () async {
                        final email = _email.text;
                        final password = _password.text;
                        final credentials = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        print(credentials);
                      },
                      child: const Text('Register'),
                    ),
                  ],
                );
              default:
                return const Text('Loading');
            }
          },
        ));
  }
}
