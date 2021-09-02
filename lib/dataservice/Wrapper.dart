import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:our_news_app/Login/login.dart';
import 'package:our_news_app/Screens/screen1.dart';
import 'package:our_news_app/dataservice/dataservice.dart';

class Wrapper{

  final Dataservice dsvar=Get.find<Dataservice>();
  checkUser(){
    var currentuser = FirebaseAuth.instance.currentUser;
    print('$currentuser curuser');
    if(currentuser!=null){
      print('$currentuser curuser');
      dsvar.userauth(currentuser.uid);
      print('${dsvar.userauth} userauth');
      return Homepage();
    }
    else{
      return Mood();
    }
  }

}