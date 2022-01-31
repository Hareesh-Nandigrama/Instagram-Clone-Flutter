import 'package:finalapp/firebase/cloudfirestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FollowDisplay extends StatefulWidget {
  final list; final String text;
  const FollowDisplay({Key? key, required this.list, required this.text}) : super(key: key);

  @override
  _FollowDisplayState createState() => _FollowDisplayState();
}

class _FollowDisplayState extends State<FollowDisplay> {

  isFollowing(){
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(widget.text, style: const TextStyle(color: Colors.black87),),
        leading: IconButton(
          onPressed: (){Navigator.of(context).pop();},
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black,),
        ),
      ),
    body: widget.list.length==0? const Center(child: Text('No users to show'),)
        :FutureBuilder(
      future: FireStrMtd().getColl('users').where('uid', whereIn: widget.list).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator(color: Colors.grey,);
        }
        return ListView.builder(
          itemCount: (snapshot.data! as dynamic).docs.length,
          itemBuilder: (context, index){
            var snap = (snapshot.data! as dynamic).docs[index];
            return ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage(snap['dp'],), radius: 20,),
                title: Text(snap['username'],),
                subtitle: Text(snap['name']),
                trailing: IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.more_vert),
                )
            );
          }
        );

      }
    )
      );
  }
}
