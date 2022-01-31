import 'dart:typed_data';
import 'package:finalapp/custom_widgets/dialoguebox.dart';
import 'package:finalapp/custom_widgets/fields.dart';
import 'package:finalapp/custom_widgets/image.dart';
import 'package:finalapp/firebase/cloudfirestore.dart';
import 'package:finalapp/screens/feed_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController caption = TextEditingController();
  Uint8List? dp;
  bool isLoading = false;

  selectImage(ImageSource temp) async {
    Uint8List file = await pickImage(temp);
    setState(() {dp = file;});
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white,
        leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_sharp, color: Colors.black,),),
        actions: [
          IconButton(
              onPressed: () async {
                if(dp == null){
                  popUp('Please select an image', context, 1, 0, Colors.red);
                }
                else
                {
                  setState(() {isLoading = true;});
                  String reply = await FireStrMtd().uploadPost(caption.text, dp!);
                  setState(() {isLoading = false;});
                  popUp(reply, context, 1, 50, Colors.blue);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Feed()));

                }
              },
              icon: const Icon(Icons.check, color: Colors.blue,)),
        ],
        title: const Text('New Post', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLoading? const LinearProgressIndicator() : const Padding(padding: EdgeInsets.all(0),),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(5,15,10,0),
                        child: InkWell(
                          onTap: (){
                            showDialog(context: context, builder: (_) =>
                                AlertDialog(
                                  title: const Center(child: Text('Select Image from')), actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    CupertinoDialogAction(child: const Text('Gallery'), onPressed: (){Navigator.of(context).pop(); selectImage(ImageSource.gallery);},),
                                    CupertinoDialogAction(child: const Text('Camera'), onPressed: (){Navigator.of(context).pop(); selectImage(ImageSource.camera);},),
                                    CupertinoDialogAction(child: const Text('Cancel', style: TextStyle(color: Colors.redAccent),), onPressed: (){Navigator.of(context).pop();},),
                                  ],
                                ),
                                barrierDismissible: true
                            );
                          },
                          child: Container(
                            width: 100, height: 70,
                            decoration: const BoxDecoration(shape: BoxShape.rectangle, color: Colors.white),
                            child: dp == null ? Column(mainAxisAlignment: MainAxisAlignment.center, children: const [Icon(Icons.image, size: 40,), Text('Select Image', style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),)],) :
                            Image.memory(dp!),
                          ),
                        )
                    ),
                    SizedBox(
                      width: 250,
                      child: TextField(
                        controller: caption, minLines: 1, maxLines: 10,
                        decoration: const InputDecoration(border: InputBorder.none, hintText: 'Write a caption...'),
                      ),
                    ),
                  ],
                ),
              ),
              Dash(),  ButtonText('Tag people'),
              Dash(),  ButtonText('Add location'), Dash(),
              NormalText('Also post to', 23.0, 10.0), NormalText('Facebook', 10.0, 10.0),
              NormalText('Twitter', 10.0, 10.0),  NormalText('Tumblr', 10.0, 23.0), Dash(),
              const Padding( padding: EdgeInsets.fromLTRB(20,10,10,0), child: Text('Advanced settings', style: TextStyle(color: Colors.grey, fontSize: 12)),),
            ],
          ),
        ),
      ),
    );
  }
}

