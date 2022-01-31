import 'package:finalapp/custom_widgets/dialoguebox.dart';
import 'package:finalapp/custom_widgets/fields.dart';
import 'package:finalapp/firebase/authentication.dart';
import 'package:flutter/material.dart';

import '../feed_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            alignment: AlignmentDirectional.centerStart,
            child: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                size: 50,
              ),
              onPressed: (){Navigator.pushNamed(context, '/first');},
            ),
          ),
          Container(
              alignment: AlignmentDirectional.center,
              height: 200,
              child: Image.asset('assets/logo.png')
          ),

          InField('Email', false, _emailController, 1,0),
          InField('Password', true, _passwordController, 2,0),
          Container(
            alignment: AlignmentDirectional.centerEnd,
            padding: const EdgeInsets.fromLTRB(0,10,25,10),
            child: const Text('Forgot password?',
              style: TextStyle(
                fontSize: 15,
                color: Colors.blue,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {isLoading = true;});
              String reply = await AuthMtds().loguser(email: _emailController.text, password: _passwordController.text);
              setState(() {isLoading = false;});
              if(reply == 'Success')
                {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Feed()));
                }
              else
                {
                  popUp(reply, context, 1, 500, Colors.redAccent);
                }

            },
            child: isLoading? const CircularProgressIndicator(color: Colors.white,) : const Text('Log in'),
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(340,50),
                padding: const EdgeInsets.all(10)
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: const Text('Or'),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                  child: const Text('Sign Up'),
                  onPressed: (){Navigator.pushNamed(context, '/signup');},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

