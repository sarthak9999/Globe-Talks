import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:our_news_app/dataservice/Wrapper.dart';
import 'package:our_news_app/dataservice/dataservice.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  goto = Wrapper().checkUser();
}

var goto;

class MyApp extends StatelessWidget {
  
  final Dataservice dtvl=Get.put(Dataservice());
  
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'cv',
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
      ),),
      home: goto,
    );
  }
}
