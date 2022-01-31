import 'package:finalapp/firebase/authentication.dart';
import 'package:finalapp/screens/initials/firstpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstaBar extends StatelessWidget {
  final int page;
  const InstaBar({Key? key, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: SizedBox(
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: (){
                Navigator.pushNamed(context, '/feed');
              },
              icon: page == 0? const Icon(Icons.home, color: Colors.black,) : const Icon(Icons.home_outlined, color: Colors.grey,) ,
            ),
            IconButton(
              onPressed: (){Navigator.pushNamed(context, '/search');},
              icon: page==1 ? const Icon(Icons.search, color: Colors.black,): const Icon(Icons.search, color: Colors.grey,),
            ),
            IconButton(
              onPressed: (){Navigator.pushNamed(context, '/post');},
              icon: page==2 ? const Icon(Icons.add_box_outlined, color: Colors.black,): const Icon(Icons.add_box_outlined, color: Colors.grey,),
            ),
            IconButton(
              onPressed: (){Navigator.pushNamed(context, '/notif');},
              icon: page==3 ? const Icon(Icons.favorite_outline_rounded, color: Colors.black,): const Icon(Icons.favorite_outline_rounded, color: Colors.grey,),
            ),
            InkWell(
              onTap: (){Navigator.pushNamed(context, '/profile');},
                onLongPress: (){
                  showDialog(context: context, builder: (_) =>
                      AlertDialog(
                        title: const Center(child: Text('Are you sure you want to logout?')), actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          CupertinoDialogAction(child: const Text('Log Out', style: TextStyle(color: Colors.redAccent),), onPressed: () async {await AuthMtds().logout(); Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => FirstPage()));},),
                          CupertinoDialogAction(child: const Text('Cancel', style: TextStyle(color: Colors.blue),), onPressed: (){ Navigator.of(context).pop();},),
                        ],
                      ),
                      barrierDismissible: true
                  );
                },
                child: page==4 ? const Icon(Icons.person, color: Colors.black,): const Icon(Icons.person, color: Colors.grey,)
            ),
          ],
        ),
      ),
    );
  }
}