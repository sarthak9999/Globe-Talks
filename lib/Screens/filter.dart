import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:our_news_app/Screens/source.dart';

class Filter extends StatefulWidget {
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {

  w(w1,pw){return pw*(w1/394);}
	h(h1,ph){return ph*(h1/851);}

  @override
  void initState() { 
    super.initState();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown,DeviceOrientation.portraitUp,]
    );
  }

  @override
  Widget build(BuildContext context) {
    var pw=Get.size.width;
    var ph=Get.size.height;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        titleSpacing: 0,
        elevation: 10,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Choose Source",
          style: TextStyle(
              fontSize: w(23,pw), color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipPath(
                  clipper: Cont1(),
                  child: Container(
                    height: h(360,ph),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.center,
                            colors: [
                          Colors.orange.withOpacity(0.4),
                          Colors.pinkAccent.withOpacity(0.4)
                        ])),
                  ),
                ),
                SizedBox(
                  height: h(50,ph),
                ),
                ClipPath(
                  clipper: Cont2(),
                  child: Container(
                    height: h(310,ph),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.center,
                            colors: [
                          Colors.pinkAccent.withOpacity(0.4),
                          Colors.orange.withOpacity(0.4)
                        ])),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: h(8.0,ph)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: w(196,pw),
                  child: ListView(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    children: [
                      _contai(Colors.purpleAccent.withOpacity(1), h(170.0,ph), h(10.0,ph),
                          h(10.0,ph), "bbc.png","Bbc News"),
                      _contai(Colors.redAccent.withOpacity(1), 200.0, h(10.0,ph),
h(10.0,ph), "et.jpg","Economic Times"),
                      _contai(Colors.black.withOpacity(1), h(170.0,ph), h(10.0,ph), h(10.0,ph),
                          "verge.png","The Verge"),
                      _contai(Colors.blueAccent.withOpacity(1), h(180.0,ph), h(10.0,ph),
h(10.0,ph), "etell.png","Engadget"),
                      _contai(Colors.orange.withOpacity(1), h(180.0,ph), h(10.0,ph), h(10.0,ph),
                          "giz.png","GizModo.com"),
                      _contai(Colors.black.withOpacity(1), h(180.0,ph), h(10.0,ph), h(10.0,ph),
                          "theguardian.png","The Guardian"),
                      SizedBox(
                        height: h(130.0,ph),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: h(16.0,ph)),
                  child: Container(
                    width: w(196,pw),
                    child: ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children: [
                        _contai(Colors.black.withOpacity(1), h(230.0,ph), h(10.0,ph),h(10.0,ph),
                            "nyt.png","New York Times"),
                        _contai(Colors.greenAccent.withOpacity(1), h(170.0,ph), h(10.0,ph),
                            h(10.0,ph), "tc.png","Techcrunch"),
                        _contai(Colors.orange.withOpacity(1), h(220.0,ph), h(10.0,ph), h(10.0,ph),
                            "reu.png","Reuters"),
                        _contai(Colors.redAccent.withOpacity(1), h(170.0,ph), h(10.0,ph),
                            h(10.0,ph), "cnn.jpg","CNN"),
                        _contai(Colors.black.withOpacity(1), h(180.0,ph), h(10.0,ph),h(10.0,ph),
                            "wired.png","Wired"),
                        SizedBox(
                          height: h(30.0,ph),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _contai(c1, he, to, bo, im,text) {
    var pw=Get.size.width;
    return GestureDetector(
      onTap: () {
        Get.to(()=>Source(text));
      },
      child: Card(
        margin: EdgeInsets.only(left: w(5,pw), right: w(5,pw), top: to, bottom: bo),
        elevation: 6,
        shadowColor: c1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          height: he,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: AssetImage("images/$im"), fit: BoxFit.fill)),
        ),
      ),
    );
  }
}

class Cont1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.quadraticBezierTo(0, 360, 392, 360);
    path.lineTo(392, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class Cont2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, 310);
    path.lineTo(392, 310);
    path.quadraticBezierTo(392, 0, 0, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}