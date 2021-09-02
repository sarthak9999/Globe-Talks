import 'dart:math';
import 'package:flutter/services.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:our_news_app/Screens/screen1.dart';
import 'package:our_news_app/Splash/splashscreen.dart';
import 'package:our_news_app/dataservice/AuthDatabase.dart';
import 'package:our_news_app/dataservice/dataservice.dart';
import 'package:pinput/pin_put/pin_put.dart';

class Otp extends StatefulWidget {

  final String email,name,password,signupotp;
  Otp(this.email,this.password,this.signupotp,{this.name});

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  ScrollController controller = ScrollController();
  var otp,code;
  final Dataservice dsvar=Get.find<Dataservice>();

  @override
  void initState() { 
    super.initState();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown,DeviceOrientation.portraitUp,]
    );
  }

  sendotp() async {
  String username = 'tanishqagarwal987@gmail.com';
  String password = 'Tanishq@987';

  final smtpServer = gmail(username, password);
  // Use the SmtpServer class to configure an SMTP server:
  // final smtpServer = SmtpServer('smtp.domain.com');
  // See the named arguments of SmtpServer for further configuration
  // options.  
  var rnd = Random();
  for(int i = 0;i<4;i++){
    otp += rnd.nextInt(9).toString();
  }
  final message = Message()
    ..from = Address(username, 'Globe Talks')
    ..recipients.add('lcs2019046@iiitl.ac.in')
    ..ccRecipients.addAll(['lcs2019021@iiitl.ac.in'])
    ..bccRecipients.add(Address('lcs2019020@iiitl.ac.in'))
    ..subject = 'Confirm E-mail 😀😀'
    // ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html = "<h3>Enter the otp written below in Globe Talks App to confirm your e-mail.</h3>\n<h3>OTP is <span style='color:blue;'>$otp</span></h3>";

  try {
    final sendReport = await send(message, smtpServer);
    if(sendReport != null){
      funsnack('OTP sent','Otp has ben sent successfully',Colors.purpleAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
    } else {
      funsnack('Error Occured','Please try again',Colors.redAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
    }
    print('Message sent: ' + sendReport.toString());
  } on MailerException catch (e) {
    print('Message not sent.');
    funsnack('Error Occured','Please try again',Colors.redAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
    for (var p in e.problems) {
      print('Problem: ${p.code}: ${p.msg}');
    }
  }
  // Create a smtp client that will persist the connection
  var connection = PersistentConnection(smtpServer);
  await connection.send(message);  // Send the otp message
  await connection.close();  // close the connection
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
    return Obx((){
      if(dsvar.verifyinguser.value){
        return SplashScreen();
        }else{
        return Scaffold(
      body: ListView(
        controller: controller,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          Stack(
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
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "Edit email address",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "I still don't trust",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "you buddy.",
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Tell me something",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "that only two of",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "us know.",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              "Enter otp sent to ",
              style: TextStyle(
                  fontSize: 27,
                  color: Colors.black.withOpacity(0.56),
                  fontWeight: FontWeight.w400),
            ),
          ),
          Center(
            child: Text(
              widget.email,
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.deepOrange.withOpacity(0.9),
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 90, right: 90, bottom: 10),
            child: PinPut(
              textStyle: TextStyle(letterSpacing: .5, fontSize: 20),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value == null || value.length == 0) {
                  controller.animateTo(250,
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInOut);
                }
              },
                onSubmit: (value)async{
                  setState(() {
                    code=value;
                    print('$code code here');
                  });
              if(code==widget.signupotp || code==otp){
                await Authservice().createEmail(widget.email,widget.password,widget.signupotp!=null?widget.signupotp:otp).then((user)async{
                  if(user[0]!=null){
                  var res = await Dataservice().funcreateuser(user[0],widget.name);
                  if(res[0]!=null){
                    dsvar.userauth(user[0].user.uid);
                    funsnack('OTP verified','Welcome to Globe Talks',Colors.purpleAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
                    Get.to(()=>Homepage());
                  }else{
                    funsnack('Error Occured','Please try again',Colors.redAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
                  }
                } else {
                  funsnack('Error Occured','Please try again',Colors.redAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
                }
                });
              }else{
                funsnack('Error Occured',"Invalid otp",Colors.pink,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
              }
                },
              fieldsCount: 4,
              followingFieldDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black.withOpacity(0.6)),
              ),
              selectedFieldDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black),
              ),
              submittedFieldDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.black),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Didn't get otp?",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black.withOpacity(0.56),
                    fontWeight: FontWeight.w400),
              ),
              GestureDetector(
                onTap:(){
                  sendotp();
                },
                child: Text(
                  " Resend otp",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.pink.withOpacity(0.8),
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Center(
            child: Card(
              elevation: 5,
              shadowColor: Colors.pink.withOpacity(0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 6),
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
                  "Verify",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 300,
          )
        ],
      ),
    );
    }
    });
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