import 'dart:typed_data';
import 'package:finalapp/custom_widgets/fields.dart';
import 'package:finalapp/custom_widgets/image.dart';
import 'package:finalapp/firebase/authentication.dart';
import 'package:finalapp/firebase/cloudfirestore.dart';
import 'package:finalapp/firebase/firebasestorage.dart';
import 'package:finalapp/screens/profiles/profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  _EditProfileState();

  //Variables to hold cloud firestore data
  TextEditingController nameC = TextEditingController();
  TextEditingController userC = TextEditingController();
  TextEditingController bioC = TextEditingController();
  TextEditingController webC = TextEditingController();
  String imurl = DEFAULTDP;
  Uint8List? dp;
  bool isUpdating = false;
  bool initial = true;

  //Function to select an image from gallery or camera and store it in dp
  selectImage(ImageSource temp) async {
    Uint8List now = await pickImage(temp);
    setState(() {
      dp = now;
    });
  }

  //Function to update dp
  UpdateDp() async {
    if(dp == null && imurl == DEFAULTDP)
    {
      if(initial){
        StorageMtds().deleteDp();
      }
    }
    else
    {
      if(dp != null)
        {
          String newdp = await StorageMtds().uploadPost(path: '', file: dp!, isPost: false);
          setState(() {imurl = newdp;});
        }
    }
  }

  @override
  void initState(){
    super.initState();
    function();
  }

  function() async {
    DocumentSnapshot snapshot = await FireStrMtd().getUserdata(id: AuthMtds().userId());
    setState(() {
      nameC.text = snapshot['name'];
      userC.text = snapshot['username'];
      bioC.text = snapshot['bio'];
      webC.text = snapshot['website'];
      imurl = snapshot['dp'];
      if(imurl == DEFAULTDP) {initial = false;} else {initial = true;}
    });
  }

  Widget bottomSheet(BuildContext context) {
    return Container( height: 100.0,  width: MediaQuery.of(context).size.width,  margin: const EdgeInsets.symmetric( horizontal: 20, vertical: 20,),
      child: Column( children: <Widget>[
        const Text( "Choose Profile photo",  style: TextStyle(fontSize: 20.0,),),
        const SizedBox(height: 20,),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
          TextButton.icon( icon: const Icon(Icons.camera), onPressed: () async { Navigator.pop(context);await selectImage(ImageSource.camera);}, label: const Text("Camera"),),
          TextButton.icon(icon: const Icon(Icons.image), onPressed: () async { Navigator.pop(context); await selectImage(ImageSource.gallery);}, label: const Text("Gallery"),),
          TextButton.icon(icon: const Icon(Icons.delete, color: Colors.red,), onPressed: () {setState(() {dp = null; imurl = DEFAULTDP;});}, label: const Text("Remove", style: TextStyle(color: Colors.red),),),]
        )],),);}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){Navigator.pushNamed(context, '/profile');},
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black,),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {isUpdating = true;});
                print('request for update dp');
                await UpdateDp();
                print('dp update success, processsing details update');
                await FireStrMtd().getColl('users').doc(AuthMtds().userId()).update({
                  'username': userC.text, 'name': nameC.text, 'bio': bioC.text, 'website': webC.text, 'dp': imurl,
                });
                print('edit profile successful');
                setState(() {isUpdating = false;});
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Profile(AuthMtds().userId())));
              },
              icon: const Icon(Icons.save, color: Colors.black,)),
        ],
        centerTitle: true,
        title: const Text('Edit Profile', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            isUpdating? LinearProgressIndicator(): Container(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,13,0,0),
              child: Container(
                child: dp !=null ?CircleAvatar(radius: 50, backgroundImage: MemoryImage(dp!),):
                CircleAvatar(radius: 50, backgroundImage: NetworkImage(imurl),),
              ),
            ),

            TextButton(
              onPressed: (){showModalBottomSheet(isDismissible: true, context: context, builder: ((builder) => bottomSheet(context)),);},
              child: const Text('Change Profile Photo'),
            ),

            InField('Name', false, nameC, 0,1),
            InField('Username', false, userC, 0, 1),
            InField('Website', false, webC, 0, 1),
            InField('Bio', false, bioC, 0, 1),
            editPro(1, 'Switch to Professional account'),
            editPro(2, 'Change Password'),

          ],
        ),
      ),
    );

  }
}




