import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:our_news_app/dataservice.dart';

class Authservice {

  FirebaseAuth _auth=FirebaseAuth.instance;
  final Dataservice dsvar=Get.find<Dataservice>();

  // return current user
  Stream<User> get user{
    return _auth.authStateChanges();
  }

  createEmail(email,password,name)async{
    try{
      dsvar.signinshop(true);
      UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return [credential];
    }catch(e){
      dsvar.signinshop(false);
      print("${e.code} from authservice login side");
      return [null,e.code];
    }finally{
      dsvar.signinshop(false);
    }
  }

  //login with email and password
  loginwithemailandpassword(String email ,String password) async{
    try{
      dsvar.signinshop(true);
      UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return [credential];
    }catch(e){
      dsvar.signinshop(false);
      print("${e.code} from authservice login side");
      return [null,e.code];
    }finally{
      dsvar.signinshop(false);
    }
  }

  //forgot password

  forgotpassword(String email) async{
    dsvar.sendingreset(true);
    try{
      await _auth.sendPasswordResetEmail(email: email);
      return ['done'];
    }catch(e){
      dsvar.sendingreset(false);
      print("$e from authservice forgot side");
      return [null,e.code];
    }finally{
      dsvar.sendingreset(false);
    }
  }

}