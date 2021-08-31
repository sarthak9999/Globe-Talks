import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';

class Otp extends StatefulWidget {

  String email,name,password;
  Otp(this.email,this.name,this.password);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  ScrollController controller = ScrollController();




  void sendotp() async {
    EmailAuth.sessionName = "Globe Talks";
    var res = await EmailAuth.sendOtp(receiverMail: widget.email);
    if (res != null) {
      funsnack('OTP sent','Otp has been sent successfully',Colors.purpleAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
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
              autofocus: true,
              onChanged: (value) {
                if (value == null || value.length == 0) {
                  controller.animateTo(250,
                      duration: Duration(milliseconds: 800),
                      curve: Curves.easeInOut);
                }
              },

              onSubmit: (value) {},
              //   onSubmit: (value)async{
              //     setState(() {
              //       code=value;
              //       print('$code code here');
              //     });
              // if(code.length==6){
              //       dsvar.verifyinguser(true);
              //   try{
              //   var user =await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: _verificationCode, smsCode: code),);
              //   print(user);
              //   if(user!=null){
              //     print(user.user.uid);
              //     dsvar.useruid(user.user.uid);
              //     dsvar.newusernumber(user.user.phoneNumber.toString().substring(3,));
              //     print(dsvar.newusernumber);
              //     Get.offAll(Wrapper());
              //     t1.cancel();
              //   }
              // }
              // catch(e){
              // print("on manually typed pin");
              // dsvar.verifyinguser(false);
              // print(e);
              // Shortcut().funsnack('Error Occured','${e.code}',Colors.redAccent,Icons.error,30.0,0.0,20.0,10.0,10.0);
              //   }finally{
              //     dsvar.verifyinguser(false);
              //   }
              // }else{
              //   Shortcut().funsnack('Error Occured',"Invalid otp",Colors.pink,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
              // }
              //   },
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