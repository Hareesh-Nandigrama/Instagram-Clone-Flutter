import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png'),
            ElevatedButton(
              onPressed: (){Navigator.pushNamed(context, '/login');},
              child: const Text('Log in'),
              style: ElevatedButton.styleFrom(minimumSize: const Size(320,0), padding: const EdgeInsets.all(10)),
            ),
            OutlinedButton(
              onPressed: (){Navigator.pushNamed(context, '/signup');},
              child: const Text('Sign up'),
              style: OutlinedButton.styleFrom(
                  primary: Colors.blueAccent,
                  minimumSize: const Size(320,0),
                  padding: const EdgeInsets.all(10),
                  side: const BorderSide(color: Colors.blueAccent,)),
            )
          ],
        ),
      ),
    );
  }
}