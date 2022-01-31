//Dm page
import 'package:finalapp/custom_widgets/tiles.dart';
import 'package:flutter/material.dart';

class Dm extends StatefulWidget {
  const Dm({Key? key}) : super(key: key);
  @override
  _DmState createState() => _DmState();
}

class _DmState extends State<Dm> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: const Icon(Icons.keyboard_arrow_left, color: Colors.black,),
        ),
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.add, color: Colors.black,)),],
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Text('honey', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
            Icon(Icons.arrow_drop_down_sharp, color: Colors.black,)],
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 45,
              child: TextField(
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.bottom,
                style: const TextStyle(
                    fontSize: 15
                ),
                obscureText: false,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[70],
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  focusColor: Colors.blue,
                  hintText: 'Search',
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(5),
              children: [
                ChatTile('Ashu','Busy peeps','now','https://www.thespruceeats.com/thmb/IHKuXcx3uUI1IWkM_cnnQdFH-zQ=/3485x2323/filters:fill(auto,1)/how-to-make-homemade-french-fries-2215971-hero-01-02f62a016f3e4aa4b41d0c27539885c3.jpg'),
                ChatTile('Anjan','ivala yevar toh kalpav','now','https://pbs.twimg.com/profile_images/880330643376414722/KVt8edG9.jpg'),
                ChatTile('Arun','Mik ante lover undi bro','now','https://w7.pngwing.com/pngs/81/810/png-transparent-kfc-bucket-of-fried-chicken-kfc-crispy-fried-chicken-chicken-fingers-kentucky-fried-chicken-popcorn-chicken-vegetarian-cuisine-kfc-food-chicken-meat-cuisine.png'),ChatTile('Venom','Did u see yesterday\'s episode','2m','https://static.toiimg.com/thumb/msid-82538914,imgsize-98159,width-800,height-600,resizemode-75/82538914.jpg'),
                ChatTile('Kailash','Goa lo enjoying aa?','1y','https://previews.123rf.com/images/ionutparvu/ionutparvu1612/ionutparvu161201547/67602894-busy-stamp-sign-text-word-logo-blue-.jpg'),
                ChatTile('Vatsav','Come lets play COD','30min','https://store-images.s-microsoft.com/image/apps.26700.13958823218105189.5a0e6185-5389-4d7e-8836-9555f629f20e.b0394933-db71-4ebf-8b2d-1100158fdb9c'),
                ChatTile('Venika','Mir ante pro coders bro','yesterday','https://image.shutterstock.com/image-vector/abstract-futuristic-cyberspace-binary-code-260nw-740523562.jpg'),
                ChatTile('Nithin','Bhabi kaisi hai?','35min','https://i.etsystatic.com/9807378/r/il/b972f3/724421053/il_570xN.724421053_961u.jpg'),
                ChatTile('Bodhitha','k bye','3day','https://i.pinimg.com/originals/24/47/5e/24475e0be55b064082100f1792c253f7.jpg'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white70,
        child: SizedBox(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: (){},
                icon: const Icon(Icons.camera_alt_rounded, color: Colors.blue, size: 35,),
              ),
              const Text('Camera', style: TextStyle(color: Colors.blue),),
            ],
          ),
        ),
      ),
    );
  }
}

