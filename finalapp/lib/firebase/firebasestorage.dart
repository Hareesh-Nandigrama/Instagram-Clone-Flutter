import 'dart:typed_data';
import 'package:finalapp/firebase/authentication.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMtds
{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String uid = AuthMtds().userId();

  uploadPost({required String path, required Uint8List file,required bool isPost}) async
  {
    print('requested upload image function');
    Reference ref = _storage.ref();
    if(isPost)
    {
      ref = ref.child('posts').child(uid).child(path);
    }
    else
    {
      ref = ref.child('dp').child(uid);
    }

    print('waiting for upload');
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;

    print('upload success, waiting to return downloadurl');
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  deleteDp() async
  {
    Reference reference = _storage.ref().child('dp/'+uid);
    await reference.delete();
  }

  deletePost({required String name}) async{
    Reference reference = _storage.ref().child('posts/'+uid).child(name);
    await reference.delete();
  }


}