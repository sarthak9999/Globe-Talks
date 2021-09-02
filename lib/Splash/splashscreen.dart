import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  w(w1,pw){return pw*(w1/394);}
	h(h1,ph){return ph*(h1/851);}

  @override
  Widget build(BuildContext context) {
    var ph = Get.size.height;
    return Scaffold(
          body: Center(
            child: Container(
            child: Stack(
              children: [
                Container(
                  child: Lottie.asset('animations/wait.json'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h(250.0,ph)),
                  child: Container(
                    child: Lottie.asset('animations/man.json'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h(450.0,ph)),
                  child: Container(
                    child: Lottie.asset('animations/clock.json'),
                  ),
                ),
              ],
            ),
          ),
          ),
        );
  }
}