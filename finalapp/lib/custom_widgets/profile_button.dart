import 'package:finalapp/firebase/authentication.dart';
import 'package:finalapp/firebase/cloudfirestore.dart';
import 'package:flutter/material.dart';

class ProfilePageButton extends StatefulWidget {
  final id;
  const ProfilePageButton({Key? key, required this.id}) : super(key: key);

  @override
  _ProfilePageButtonState createState() => _ProfilePageButtonState();
}

class _ProfilePageButtonState extends State<ProfilePageButton> {

  bool isFollowing = false;
  bool decision = false;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    function();
  }

  function() async{

    if(widget.id != AuthMtds().userId())
      {
         setState(() {
           isLoading = true;
         });
         bool isFollow = await FireStrMtd().checkFollowing(target: widget.id, src: AuthMtds().userId());
         setState(() {isFollowing = isFollow; isLoading = false;});
      }
    else
      {
        setState(() {
          decision = true;
        });
      }
  }

  @override
  Widget build(BuildContext context) {

    //Edit Profile button
    if(decision)
      {
        return OutlinedButton(
          onPressed: (){
            Navigator.pushNamed(context, '/edit_profile');
          },
          child: Text('Edit profile'),
          style: OutlinedButton.styleFrom(
              primary: Colors.black,
              minimumSize: Size(370,10),
              padding: EdgeInsets.all(10),
              side: BorderSide(color: Colors.grey,)
          ),
        );
      }
    else {
      //Check if following
      if (isLoading) {
        return Container();
      }
      else {
        if (isFollowing) {
          return OutlinedButton(
            onPressed: () {},
            child: const Text(
              'Following', style: TextStyle(color: Colors.black),),
            style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                primary: Colors.black,
                minimumSize: const Size(370, 10),
                padding: const EdgeInsets.all(10),
                side: const BorderSide(color: Colors.grey,)
            ),
          );
        }
        else {
          return OutlinedButton(
            onPressed: () {},
            child: const Text('Follow', style: TextStyle(color: Colors.white),),
            style: OutlinedButton.styleFrom(
                backgroundColor: Colors.blue,
                primary: Colors.black,
                minimumSize: const Size(370, 10),
                padding: const EdgeInsets.all(10),
                side: const BorderSide(color: Colors.blue,)
            ),
          );
        }
      }
    }
  }

}
