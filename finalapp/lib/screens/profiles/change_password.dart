import 'package:finalapp/custom_widgets/dialoguebox.dart';
import 'package:finalapp/firebase/authentication.dart';
import 'package:finalapp/screens/initials/firstpage.dart';
import 'package:flutter/material.dart';

class Reset extends StatefulWidget {

  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  _ResetState();

  TextEditingController password = TextEditingController();
  TextEditingController npassword = TextEditingController();
  TextEditingController cpassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      password.text = '';
      npassword.text = '';
      cpassword.text = '';
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/edit_profile');
          },
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black,),
        ),
        actions: [
          TextButton(
            child: const Text('Save', style: TextStyle(color: Colors.grey)),
            onPressed: ()
            async {
              if(password.text != '' && npassword.text != '' && cpassword.text != '') {
                  if(npassword.text == cpassword.text) {
                      if(npassword.text.length >= 6) {
                           bool answer = await AuthMtds().checkCurrentPassword(password.text);
                           if(answer) {
                                await AuthMtds().inst().currentUser.updatePassword(npassword.text);
                                await AuthMtds().logout();
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FirstPage()));
                               popUp('Password Successfully Updated', context, 1, 500, Colors.blue);
                             }
                           else{popUp('Incorrect Current Password', context, 1, 500, Colors.red);}}
                      else {popUp('New Password Must Be Atleast 6 characters', context, 1, 500, Colors.red);}}
                  else {popUp('New Passwords Dont Match', context, 1, 500, Colors.red);}}
              else {popUp('Please fill all fields', context, 1, 500, Colors.red);}
            },
          )
        ],
        centerTitle: true,
        title: const Text(
            'Change Password', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
              child: Text(
                  'Your password must be more than six characters and include a combination of numbers, letters and special characters (!\$@%).',
                  style: TextStyle(color: Colors.grey[700]))
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: TextField(
              obscureText: true,
              controller: password,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Current Password',
              ),
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: TextField(
              obscureText: true,
              controller: npassword,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'New Password',
              ),
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: TextField(
              obscureText: true,
              controller: cpassword,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm New Password',
              ),
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}

function()
{
  return true;
}

