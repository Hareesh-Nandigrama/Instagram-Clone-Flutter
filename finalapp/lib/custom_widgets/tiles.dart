import 'package:flutter/material.dart';

class Story extends StatelessWidget {
  Story(this.name, this.dp);
  final name;
  final dp;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(radius: 35, backgroundColor: Colors.red,
          child: CircleAvatar(radius: 33, backgroundColor: Colors.white,
            child: CircleAvatar(radius: 31, backgroundImage: NetworkImage(dp),),
          ),
        ),
        Text(name),
      ],
    );
  }
}

class ChatTile extends StatelessWidget {
  ChatTile(this.name,this.msg,this.last,this.dp);
  final name;final msg; final last; final dp;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(dp),
      ),
      trailing: const Icon(Icons.camera_alt_outlined,),
      title: Text(name),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(msg),
          Text(last),
        ],
      ),
    );
  }
}


class SearchTile extends StatelessWidget {
  final snap;
  const SearchTile({Key? key, required this.snap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(snap['dp'],), radius: 20,),
      title: Text(snap['username'],),
      subtitle: Text(snap['name']),
    );
  }
}

