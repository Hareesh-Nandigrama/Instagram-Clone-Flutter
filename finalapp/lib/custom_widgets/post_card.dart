import 'package:finalapp/firebase/authentication.dart';
import 'package:finalapp/firebase/cloudfirestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {

  DocumentSnapshot? _snapshot;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userDataRetrive();

  }

  userDataRetrive() async {
    DocumentSnapshot snapshot = await FireStrMtd().getUserdata(id: widget.snap['uid']);
    if(!mounted){return;}
    setState(() {
      _snapshot = snapshot;
    });

  }

  @override
  Widget build(BuildContext context) {
    return _snapshot == null?
    const Center(child: CircularProgressIndicator(color: Colors.grey,)) :
    Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(_snapshot!['dp']),
            ),
            trailing: _snapshot!['uid'] == AuthMtds().userId() ?
            IconButton(icon: const Icon(Icons.more_vert_outlined), onPressed: (){
              showDialog(context: context, builder: (_) =>
                  AlertDialog(
                    title: const Center(child: Text('Are you sure you want to delete?')), actionsAlignment: MainAxisAlignment.center,
                    actions: [
                      CupertinoDialogAction(child: const Text('Delete Post'), onPressed: () async { Navigator.of(context).pop(); await FireStrMtd().deletePost(postid: widget.snap['postid']); },),
                      CupertinoDialogAction(child: const Text('Cancel', style: TextStyle(color: Colors.redAccent),), onPressed: (){Navigator.of(context).pop();},),
                    ],
                  ),
                  barrierDismissible: true
              );

            },):
            IconButton(icon: const Icon(Icons.more_vert_outlined), onPressed: (){},),
            title: Text(_snapshot!['username']),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              height: MediaQuery.of(context).size.height * 0.35,
              width: MediaQuery.of(context).size.width,
              child: Image.network(widget.snap['image'], fit: BoxFit.cover,)),
          Row(
            children: [
              IconButton(
                  icon: widget.snap['likes'].contains(AuthMtds().userId()) ? const Icon(Icons.favorite, color: Colors.red,) :const Icon(Icons.favorite_outline_rounded),
                  onPressed: ()
                  async {
                    await FireStrMtd().likePost(widget.snap['postid'],AuthMtds().userId() , widget.snap['likes']);
                  }
              ),
              IconButton(onPressed: (){}, icon: const Icon(Icons.messenger_outline_rounded)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.send, color: Colors.black87,)),
              Expanded(child: Align(alignment: Alignment.bottomRight, child: IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_border),)),)
            ],
          ),

          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DefaultTextStyle(
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w800),
                      child: Text('${widget.snap['likes'].length} likes',style: Theme.of(context).textTheme.bodyText2,)),
                  Container(
                    width: double.infinity, padding: const EdgeInsets.only(top: 8,),
                    child: RichText(  text: TextSpan(style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan( text: _snapshot!['username'], style: const TextStyle(fontWeight: FontWeight.bold,),),
                        TextSpan(text: '  '+widget.snap['caption'],),
                      ],
                    ),
                    ),
                  ),
                  InkWell(
                    child: Container(
                      child: const Text('View all  comments', style: TextStyle(fontSize: 16, color: Colors.black87,),),
                      padding: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(DateFormat.yMMMd().format(widget.snap['date'].toDate()),
                      style: const TextStyle(color: Colors.black,),),
                  )
                ],
              )
          )
        ]
    );
  }
}