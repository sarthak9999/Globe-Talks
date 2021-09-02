import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:our_news_app/dataservice/dataservice.dart';

class Authservice {

  FirebaseAuth _auth=FirebaseAuth.instance;
  final Dataservice dsvar=Get.find<Dataservice>();

  // return current user
  Stream<User> get user{
    return _auth.authStateChanges();
  }

  createEmail(email,password,name)async{
    try{
      dsvar.verifyinguser(true);
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return [credential];
    }catch(e){
      dsvar.verifyinguser(false);
      print("${e.code} from authservice login side");
      return [null,e.code];
    }finally{
      dsvar.verifyinguser(false);
    }
  }

  //login with email and password
  loginwithemailandpassword(String email ,String password) async{
    dsvar.verifyinguser(true);
    try{
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return [credential];
    }catch(e){
      dsvar.verifyinguser(false);
      print("${e.code} from authservice login side");
      return [null,e.code];
    }finally{
      dsvar.verifyinguser(false);
    }
  }

  //forgot password

  forgotpassword(String email) async{
    dsvar.verifyinguser(true);
    try{
      await _auth.sendPasswordResetEmail(email: email);
      return ['done'];
    }catch(e){
      dsvar.verifyinguser(false);
      print("$e from authservice forgot side");
      return [null,e.code];
    }finally{
      dsvar.verifyinguser(false);
    }
  }

}