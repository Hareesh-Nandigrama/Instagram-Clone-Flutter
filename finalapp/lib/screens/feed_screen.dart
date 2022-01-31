//main page
import 'package:finalapp/custom_widgets/navigation_bar.dart';
import 'package:finalapp/custom_widgets/post_card.dart';
import 'package:finalapp/custom_widgets/tiles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'message.dart';


class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.black,
          size: 30,
        ),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Dm()),);
          }, icon: const Icon(Icons.send, color: Colors.black,)),
        ],
        centerTitle: true,
        title: SizedBox(
            height: 93,
            child: Image.asset('assets/logo.png')),
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Story('Your story','https://static.toiimg.com/thumb/msid-82427703,imgsize-379934,width-800,height-600,resizemode-75/82427703.jpg'),Container(width: 15,),
                  Story('Arun','https://w7.pngwing.com/pngs/81/810/png-transparent-kfc-bucket-of-fried-chicken-kfc-crispy-fried-chicken-chicken-fingers-kentucky-fried-chicken-popcorn-chicken-vegetarian-cuisine-kfc-food-chicken-meat-cuisine.png'), Container(width: 15,),
                  Story('Ashu','https://www.thespruceeats.com/thmb/IHKuXcx3uUI1IWkM_cnnQdFH-zQ=/3485x2323/filters:fill(auto,1)/how-to-make-homemade-french-fries-2215971-hero-01-02f62a016f3e4aa4b41d0c27539885c3.jpg'),Container(width: 15,),
                  Story('Anjan','https://pbs.twimg.com/profile_images/880330643376414722/KVt8edG9.jpg'),Container(width: 15,),
                  Story('Kailash','https://previews.123rf.com/images/ionutparvu/ionutparvu1612/ionutparvu161201547/67602894-busy-stamp-sign-text-word-logo-blue-.jpg')
                ],
              ),
            ),
            Flexible(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('posts').orderBy('date', descending: true).snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot)
                {
                  if(snapshot.connectionState == ConnectionState.waiting)
                  {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) => PostCard(
                          snap: snapshot.data!.docs[index].data()
                      )
                  );
                },

              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const InstaBar(page: 0,),
    );
  }
}



