import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'dart:html';
import 'package:our_news_app/otp.dart';

class Mood extends StatefulWidget {
  @override
  _MoodState createState() => _MoodState();
}

class _MoodState extends State<Mood> {

    var _formkey=GlobalKey<FormState>();
    var _formkey1=GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController name = TextEditingController();


    void sendotp() async {
    EmailAuth.sessionName = "Globe Talks";
    var res = await EmailAuth.sendOtp(receiverMail: email.text);
    if (res != null) {
      funsnack('OTP sent','Otp has ben sent successfully',Colors.purpleAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
    } else {
      funsnack('Error Occured','Please try again',Colors.redAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
    }
  }

  capitalizeFirstOfEach(s){return s.replaceAll(RegExp(' +'), ' ').split(" ").map((str) => str.toString().capitalize).join(" ");}

  funsnack(title,desc,Color c1,IconData i1,isize,to,bo,le,ri){
    var pw=Get.size.width;
    return Get.snackbar(
      '',"",
      titleText: Text(capitalizeFirstOfEach(title.toString()),style:TextStyle(fontFamily:'cv',color: Colors.white,fontWeight: FontWeight.bold,fontSize: w(19,pw))),
      messageText: Text(desc.toString().capitalizeFirst,style:TextStyle(fontFamily: "cv",fontSize: w(16,pw),color:Colors.white)),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.only(bottom:bo,left: le,right: ri,top:to),
      icon:Icon(i1,color: Colors.white,size:isize,),
      backgroundColor: c1,
      shouldIconPulse: false,
      duration: Duration(milliseconds: 1800),
      );
  }

  w(w1,pw){return pw*(w1/360);}
	h(h1,ph){return ph*(h1/760);}


  @override
  Widget build(BuildContext context) {
    var pw=Get.size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, bool) {
            return [
              SliverAppBar(
                forceElevated: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                titleSpacing: 0,
                toolbarHeight: 380,
                elevation: 10,
                shadowColor: Colors.black.withOpacity(0.7),
                backgroundColor: Colors.white.withOpacity(0.95),
                title: _sta(),
                bottom: TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Colors.black,
                  labelPadding: EdgeInsets.symmetric(horizontal: 40),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.black.withOpacity(0.8),
                  tabs: [
                    Tab(
                      child: Text('Login',
                          style: TextStyle(
                            fontSize: 21,
                          )),
                    ),
                    Tab(
                      child: Text('Sign up',
                          style: TextStyle(
                            fontSize: 21,
                          )),
                    ),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            children: [
              ListView(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal:35.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Email",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.orange.withOpacity(0.95)),),
                        Icon(Icons.email_rounded,color: Colors.red.withOpacity(0.9),size:30)
                      ],
                    ),
                  ),
                     Container(margin: EdgeInsets.only(left:w(30,pw),right: w(30,pw)),
                     height: 50,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        child: Align(alignment: Alignment.topCenter,
                          child: TextFormField(keyboardType: TextInputType.name,cursorColor: Colors.black.withOpacity(0.6),maxLines: 2,minLines: 1,
                          cursorHeight: 30,
                          style: TextStyle(color: Colors.white),
                          controller: email,
                            decoration: InputDecoration(
                              hintText: "abc@gmail.com",hintStyle: TextStyle(color: Colors.grey)
                            ),
                          ),
                        ),),
                  SizedBox(height:40),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal:35.0),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Password",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.pink.withOpacity(0.95)),),
                        Icon(Icons.lock_outline,color: Colors.brown.withOpacity(0.95),size:25)
                      ],
                    ),
                  ),
                  Container(margin: EdgeInsets.only(left:w(30,pw),right: w(30,pw)),
                     height: 50,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                        child: Align(alignment: Alignment.topCenter,
                          child: TextFormField(keyboardType: TextInputType.name,obscureText: true,
                          cursorColor: Colors.black.withOpacity(0.6),maxLines: 1,
                          cursorHeight: 30,
                          style: TextStyle(color: Colors.black),
                          controller: password,
                            decoration: InputDecoration(
                              hintText: "abc@1234",hintStyle: TextStyle(color: Colors.grey,),
                            ),
                          ),
                        ),),
                Align(alignment: Alignment.topLeft,
                  child: Padding(
                      padding:  EdgeInsets.only(left:35.0,top: 20),
                      child: Text("Forgot Password?",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w100,color: Colors.red.withOpacity(0.95)),),
                    ),
                ),
                ],
              ),
            ),SizedBox(height: 40,),       
            GestureDetector(
                    onTap: (){
                        if(email.text.length==0 || !EmailValidator.validate(email.text)){return funsnack('Error Occured','Enter valid email',Colors.redAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);}
                        else if(password.text.length==0){return funsnack('Error Occured','Enter valid password',Colors.redAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);}
                        else{
                          // Get.to(()=>Otp(email.text,name.text,password.text));
                        }
                    },
                      child: Center(
                      child: Card(
                        elevation: 5,
                        shadowColor: Colors.pink.withOpacity(0.6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Colors.orange.withOpacity(0.6),
                                    Colors.pinkAccent.withOpacity(0.6),
                                  ])),
                          child: Text("Verify",style: TextStyle(color: Colors.white,fontSize: 26,fontWeight: FontWeight.bold),),
                        ),
                      ),
                    ),
                  ),               
                ],
              ),
              SingleChildScrollView(physics: ClampingScrollPhysics(),
                child: Form(
          key: _formkey1,
          child: Column(
                  children: [
                    Padding(
                      padding:  EdgeInsets.only(left:35.0,right:35,top:30),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Name",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.blue.withOpacity(0.95)),),
                          Icon(Icons.person,color: Colors.blueAccent.withOpacity(0.95),size:32)
                        ],
                      ),
                    ),
                       Container(margin: EdgeInsets.only(left:w(30,pw),right: w(30,pw)),
                       height: 50,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                          child: Align(alignment: Alignment.topCenter,
                            child: TextFormField(keyboardType: TextInputType.name,cursorColor: Colors.black.withOpacity(0.6),maxLines: 2,minLines: 1,
                            cursorHeight: 30,
                            controller: name,
                            style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                hintText: "Star wars",hintStyle: TextStyle(color: Colors.grey,)
                              ),
                            ),
                          ),),
                    SizedBox(height:30),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal:35.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Email",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.orange.withOpacity(0.95)),),
                          Icon(Icons.email_rounded,color: Colors.red.withOpacity(0.95),size:30)
                        ],
                      ),
                    ),
                       Container(margin: EdgeInsets.only(left:w(30,pw),right: w(30,pw)),
                       height: 50,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                          child: Align(alignment: Alignment.topCenter,
                            child: TextFormField(keyboardType: TextInputType.name,cursorColor: Colors.black.withOpacity(0.6),maxLines: 2,minLines: 1,
                            cursorHeight: 30,
                            style: TextStyle(color: Colors.black),
                              controller: email,
                              decoration: InputDecoration(
                                hintText: "abc@gmail.com",hintStyle: TextStyle(color: Colors.grey,)
                              ),
                            ),
                          ),),  SizedBox(height:30),
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal:35.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Create Password",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.pink.withOpacity(0.95)),),
                          Icon(Icons.lock_outline,color: Colors.brown.withOpacity(0.95),size:25)
                        ],
                      ),
                    ),
                    Container(margin: EdgeInsets.only(left:w(30,pw),right: w(30,pw)),
                       height: 50,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                          child: Align(alignment: Alignment.topCenter,
                            child: TextFormField(keyboardType: TextInputType.name,obscureText: true,
                            cursorColor: Colors.black.withOpacity(0.6),maxLines: 1,
                            cursorHeight: 30,
                            style: TextStyle(color: Colors.black),
                              controller: password,
                              decoration: InputDecoration(
                                hintText: "abc@1234",hintStyle: TextStyle(color: Colors.grey,),
                              ),
                            ),
                          ),),
                  SizedBox(height:20),
                  GestureDetector(
                      onTap: (){
                        if(name.text.length==0){return funsnack('Error Occured','Enter valid name',Colors.redAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);}
                        else if(email.text.length==0 || !EmailValidator.validate(email.text)){return funsnack('Error Occured','Enter valid email',Colors.redAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);}
                        else if(password.text.length==0){return funsnack('Error Occured','Enter valid password',Colors.redAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);}
                        else{
                          sendotp();
                          Get.to(()=>Otp(email.text,name.text,password.text));
                        }
                    },
                      child: Center(
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.pink.withOpacity(0.6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.orange.withOpacity(0.6),
                                      Colors.pinkAccent.withOpacity(0.6),
                                    ])),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),],
                ),
        ),
              ),
        
              
                
            ],
          ),
        ),
      ),
    );
  }
}

class Cont1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 220);
    path.quadraticBezierTo(0, 380, 186, 380);
    path.quadraticBezierTo(392, 380, 392, 140);
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
    path.moveTo(280, 0);
    path.quadraticBezierTo(186, 100, 186, 200);
    path.quadraticBezierTo(186, 400, 392, 400);
    path.lineTo(392, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class Cont3 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 400);
    path.quadraticBezierTo(220, 400, 310, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class Cont4 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(100, 0);
    path.quadraticBezierTo(100, 270, 392, 270);
    path.lineTo(392, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

Widget _sta() {
  return Stack(
    children: [
      ClipPath(
        clipper: Cont1(),
        child: Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.pinkAccent.withOpacity(0.3),
                Colors.orange.withOpacity(0.3)
              ])),
        ),
      ),
      ClipPath(
        clipper: Cont2(),
        child: Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Colors.orange.withOpacity(0.35),
                Colors.pinkAccent.withOpacity(0.35),
              ])),
        ),
      ),
      ClipPath(
        clipper: Cont3(),
        child: Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topCenter,
                  colors: [
                Colors.orange.withOpacity(0.45),
                Colors.pinkAccent.withOpacity(0.45),
              ])),
        ),
      ),
      ClipPath(
        clipper: Cont4(),
        child: Container(
          height: 400,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.orange.withOpacity(0.6),
                Colors.pinkAccent.withOpacity(0.6),
              ])),
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 30),
        height: 400,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.34),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                    child: Text(
                      "Short",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.34),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                    child: Text(
                      "Presize",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.34),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                    child: Text(
                      "Sure",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Center(
              child: Text(
                "Welcome to",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "Globe Talks",
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Keep you updated and ahead",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "forward from rest of the world",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black.withOpacity(0.5),
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )
    ],
  );
}