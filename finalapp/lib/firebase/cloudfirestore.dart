import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalapp/firebase/authentication.dart';
import 'package:finalapp/firebase/firebasestorage.dart';

import '../constants.dart';

class FireStrMtd
{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getColl(String name) {return _firestore.collection(name);}



  createUser({required String email, required String uid, required String username}) async
  {
    print('Started firestore setup');
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'email': email,
      'username': username,
      'name': '',
      'website': '',
      'bio': '',
      'followers': [],
      'following': [],
      'dp': DEFAULTDP
    });
    print('finished firestore setup');
  }

  getUserdata({required String id})async
  {
    print('awaiting user information');
    DocumentSnapshot data = await _firestore.collection('users').doc(id).get();
    return data;
  }

  uploadPost(String caption, Uint8List file) async
  {
    String res = "Some error occurred";
    try
    {

      DateTime now = DateTime.now(); String nowString = now.toString();
      String uid = AuthMtds().userId(); String postId = uid+nowString;

      print('Starting image upload');
      String postimageurl = await StorageMtds().uploadPost(path: postId, file: file, isPost: true);
      print('image upload complete');
      print('Starting firestore update');
      _firestore.collection('posts').doc(postId).set({
        'postid': postId,
        'image': postimageurl,
        'uid': uid,
        'date': now,
        'caption': caption,
        'likes': []
      });
      print('firestore update complete');
      res = "Your Post Has Been Uploaded";
    }
    catch (err)
    {
      res = err.toString();
    }
    return res;
  }

  deletePost({required String postid}) async{
    print('processing delete post request');
    print('deleting post data from firestore');
    await _firestore.collection('posts').doc(postid).delete();
    print('Completed deleting post data');
    print('deleting image from database');
    await StorageMtds().deletePost(name: postid);
    print('image deletion complete');

  }

  likePost(String postId, String uid, List likes) async {
    print('initiating lke request');
    try
    {
      if(likes.contains(uid))
      {
        await _firestore.collection('posts').doc(postId).update({'likes': FieldValue.arrayRemove([uid])});
      }
      else
        {
          await _firestore.collection('posts').doc(postId).update({'likes': FieldValue.arrayUnion([uid])});
        }
      print('request complete');
    }
    catch(e)
    {
      print(e.toString());
    }


  }

  checkFollowing({required String target, required String src}) async {
    //We need to check if source is following target
    //getting firestore data of target

    //print('checking following');
    DocumentSnapshot snapshot = await _firestore.collection('users').doc(target).get();

    //checking if src is present in followers of target
    if(snapshot['followers'].contains(src)) {return true;} else {return false;}
  }

  follow({required String user, required bool todo}) async {

    String current_user = AuthMtds().userId();

    if(todo) //todo == true means i am following the user, and i should unfollow
      {
        await _firestore.collection('users').doc(user).update({
          'followers': FieldValue.arrayRemove([current_user])
        });

        await _firestore.collection('users').doc(current_user).update({
          'following': FieldValue.arrayRemove([user])
        });
      }
    else  //todo == false means i am not following the user, and i should follow
      {
      await _firestore.collection('users').doc(user).update({
        'followers': FieldValue.arrayUnion([current_user])
      });

      await _firestore.collection('users').doc(current_user).update({
        'following': FieldValue.arrayUnion([user])
      });
      }

  }


}