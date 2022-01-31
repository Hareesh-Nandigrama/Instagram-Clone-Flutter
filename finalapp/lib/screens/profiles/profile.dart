//profile page
import 'package:finalapp/custom_widgets/navigation_bar.dart';
import 'package:finalapp/firebase/authentication.dart';
import 'package:finalapp/firebase/cloudfirestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalapp/screens/profiles/follower.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class Profile extends StatefulWidget {
  final String uid;
  Profile(this.uid);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String username = 'username';
  String name = 'name';
  String bio = 'bio';
  String website = 'website';
  int posts = 0;
  var followers = [];
  var following = [];
  String image = DEFAULTDP;
  _ProfileState();

  @override
  void initState(){
    super.initState();
    function();
  }

  function() async{
    DocumentSnapshot snapshot = await FireStrMtd().getUserdata(id: widget.uid);
    var postSnap = await FireStrMtd().getColl('posts').where('uid', isEqualTo: widget.uid).get();
    setState(() {
      username = snapshot['username'];
      name = snapshot['name'];
      bio = snapshot['bio'];
      website = snapshot['website'];
      image = snapshot['dp'];
      followers = snapshot['followers'];
      following = snapshot['following'];
      posts = postSnap.docs.length;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0,15,0,0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: (){}, icon : const Icon(Icons.arrow_drop_down_sharp)),
                Text(username, style: const TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(image),
                ),
                Column(children: [Text('$posts', style: const TextStyle(fontWeight: FontWeight.w500),), const Text('Posts',style: TextStyle(fontWeight: FontWeight.w500),)],),
                InkWell(onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => FollowDisplay(list: followers, text: 'Followers',) ));},child: Column(children: [Text('${followers.length}', style: const TextStyle(fontWeight: FontWeight.w500),), const Text('Followers', style: TextStyle(fontWeight: FontWeight.w500),)],)),
                InkWell(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => FollowDisplay(list: following, text: 'Following',) ));} ,child: Column(children: [Text('${following.length}', style: const TextStyle(fontWeight: FontWeight.w500),), const Text('Following', style: TextStyle(fontWeight: FontWeight.w500),)],)),
              ],
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(name), Text(bio, style: const TextStyle(color: Colors.black),), Text(website),],
              ),
            ),
            Center(child: OutlinedButton(
              onPressed: (){
                Navigator.pushNamed(context, '/edit_profile');
              },
              child: const Text('Edit profile'),
              style: OutlinedButton.styleFrom(
                  primary: Colors.black,
                  minimumSize: const Size(370,10),
                  padding: const EdgeInsets.all(10),
                  side: const BorderSide(color: Colors.grey,)
              ),
            )),
            FutureBuilder(
                future: FirebaseFirestore.instance.collection('posts').where('uid', isEqualTo: widget.uid).get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                        (snapshot.data! as dynamic).docs[index];
                        return InkWell(
                          child: Container(
                            padding: const EdgeInsets.all(1),
                            child: Image(
                              image: NetworkImage(snap['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      });
                }
            )
          ],),
      ),
      bottomNavigationBar: widget.uid == AuthMtds().userId()? const InstaBar(page: 4): Container(),
    );
  }
}