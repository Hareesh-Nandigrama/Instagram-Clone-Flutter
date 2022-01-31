//search page
import 'package:finalapp/custom_widgets/fields.dart';
import 'package:finalapp/custom_widgets/navigation_bar.dart';
import 'package:finalapp/custom_widgets/tiles.dart';
import 'package:finalapp/firebase/authentication.dart';
import 'package:finalapp/firebase/cloudfirestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'profiles/other_profile.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController _search = TextEditingController();
  bool showPost = true;


  _SearchState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 10,
          leadingWidth: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Container(
            width: double.infinity,
            height: 40,
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _search,
                    textAlign: TextAlign.left,

                    textAlignVertical: TextAlignVertical.bottom,
                    decoration:
                    InputDecoration
                      (
                      filled: true,
                        focusColor: Colors.grey[70],
                        fillColor: Colors.grey[150],
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    onSubmitted: (String _) {

                      //print(_);
                      //print(_searchController.text);
                      setState(() {
                        showPost = false;
                      });
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 7),
                  child: Icon(Icons.crop_free_rounded,
                    color: Colors.grey,),
                )
              ],
            ),
          ),
      ),
      body:
      showPost?
      Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  SearchField(fieldname: 'IGTV', iconId: 0xf16f), SearchField(fieldname: 'Shop', iconId: 0xe59c),
                  SearchField(fieldname: 'Style', iconId: 0xe613), SearchField(fieldname: 'Sports', iconId: 0xf3cb),
                  SearchField(fieldname: 'Auto', iconId: 0xe13c), SearchField(fieldname: 'Persons', iconId: 0xe491),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: FireStrMtd().getColl('posts').get(),
                builder: (context, snapshot)
                {
                  if(!snapshot.hasData) {return const Center(child: CircularProgressIndicator(color: Colors.grey,));}
                  return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      itemBuilder: (context, index)
                      {
                        return
                          Container(
                            padding: const EdgeInsets.all(1),
                            child: Image.network((snapshot.data! as dynamic).docs[index]['image'], fit: BoxFit.cover,),
                          );
                      });
                }
            ),
          ),
        ],
      ):


        FutureBuilder(
          future: FireStrMtd().getColl('users').
          where('username', isGreaterThanOrEqualTo: _search.text,).get(),
          builder: (context, snapshot) {
            if(!snapshot.hasData) {return const CircularProgressIndicator(color: Colors.grey,);}
            return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    String userid = (snapshot.data! as dynamic).docs[index]['uid'];
                    if(userid == AuthMtds().userId())
                      {
                        Navigator.pushNamed(context, '/profile');
                      }
                    else
                      {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Other(userid)));
                      }

                  },
                    child: SearchTile(snap: (snapshot.data! as dynamic).docs[index]),
                );
              },
            );
          }
      ),
      bottomNavigationBar: const InstaBar(page: 1)


    );
  }
}






