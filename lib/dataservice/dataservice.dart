import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Dataservice extends GetxController{


  final FirebaseFirestore _fs=FirebaseFirestore.instance;


  var signinshop=false.obs;
  var sendingreset=false.obs;
  var verifyinguser = false.obs;
  var userauth = ''.obs;

  funadd(uid,title, date, time, desc, url, cate,name,publish,{author}) async {
    try {
      print('$userauth user');
      await _fs.collection('Users').doc(uid).collection("Bookmarks").add({
        'title': title,
        'date': date,
        'time': time,
        'desc': desc,
        'url': url,
        'cate': cate,
        'name': name,
        'publish':publish
      });
      return ['done'];
    } catch (e) {
      return [null, e.code];
    }
  }

  funremove(uid,id) async {
    try {
      await _fs.collection('Users').doc(uid).collection("Bookmarks").doc(id).delete();
      return ['done'];
    } catch (e) {
      return [null, e.code];
    }
  }

  funcheckemail(String emailAddress) async {
    verifyinguser(true);
  try {
    var list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(emailAddress);
    print('$list list here');
    if (list.isNotEmpty) {
      return [true];
    } else {
      return [false];
    }
  } catch (e) {
    verifyinguser(false);
    print('${e.code} error in checking user e-mail');
    return [null,e.code];
  }
}


  funcreateuser(UserCredential user,name,)async{
    verifyinguser(true);
    try{
      await _fs.collection('Users').doc(user.user.uid.toString()).set({
        'email': user.user.email,
        'name':name
      });
      userauth(user.user.uid);
      return ['done'];
    }catch(e){
      verifyinguser(false);
      print('${e.code} error in creating users');
      return[null,e.code];
    }finally{
      verifyinguser(false);
    }
  }


}