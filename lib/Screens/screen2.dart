import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:our_news_app/dataservice/dataservice.dart';

class Screen2 extends StatefulWidget {

  final String image,title,desc,cate,name,publish,author;
  Screen2(this.image,this.title,this.desc,this.cate,this.name,this.publish,{this.author});

  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {

  final Dataservice dsvar=Get.find<Dataservice>();

  fundatetime(publish,type){
    if(type==0){
      var da = publish.toString().substring(8,10);
      var mo = publish.toString().substring(5,7);
      var month;
      if (mo=='01'){month = 'Jan';}
      if (mo=='02'){month = 'Feb';}
      if (mo=='03'){month = 'March';}
      if (mo=='04'){month = 'April';}
      if (mo=='05'){month = 'May';}
      if (mo=='06'){month = 'June';}
      if (mo=='07'){month = 'July';}
      if (mo=='08'){month = 'Aug';}
      if (mo=='09'){month = 'Sept';}
      if (mo=='10'){month = 'Oct';}
      if (mo=='11'){month = 'Nov';}
      if (mo=='12'){month = 'Dec';}
      var year = publish.toString().substring(0,4);
      var fin = da + ' ' + month + ' '+ year;
      return fin;
    }
    else{
      var hr = int.parse(publish.toString().substring(11,13));
      var fin;
      if(hr>12){
        fin = (hr-12).toString()+ ':' + publish.toString().substring(14,16) + 'pm';
      }
      else{
        fin = hr.toString()+ ':' + publish.toString().substring(14,16) + 'am';
      }
      return fin;
    }
  }

  w(w1,pw){return pw*(w1/394);}
	h(h1,ph){return ph*(h1/851);}

  @override
  void initState() { 
    super.initState();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown,DeviceOrientation.portraitUp,]
    );
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


  @override
  Widget build(BuildContext context) {
    var ph = Get.size.height;
    var pw = Get.size.width;
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          Stack(
            children: [
              Container(
                height: h(400,ph),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.image),
                        fit: BoxFit.fill),
                    boxShadow: [BoxShadow(color: Colors.grey)]),
                child: Container(
                  height: h(400,ph),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withOpacity(0.7)
                        ]),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: h(10.0,ph), left: w(20,pw), right: w(20,pw)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Container(
                                  height: h(35,ph),
                                  width: w(35,pw),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.arrow_back,
                                      color: Colors.black, size: w(22,pw))),
                            ),
                            SizedBox(
                              width: w(200,pw),
                            ),
                            GestureDetector(
                              onTap: ()async{
                              var res = await Dataservice().funadd(dsvar.userauth.toString(),widget.title,fundatetime(widget.publish,0),fundatetime(widget.publish,1),widget.desc,widget.image,'Breaking',widget.name,widget.publish,author:widget.author);
                              if(res[0]!=null){
                                funsnack('News Added','News added to your bookmarks',Colors.purpleAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
                              }else{
                                funsnack('Error Occured',res[1].toString(),Colors.redAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
                              }
                              },
                              child: Container(
                                  height: h(34,ph),
                                  width: w(34,pw),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(Icons.bookmark_outline,
                                      color: Colors.deepOrange, size: w(22,pw))),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h(220,ph),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: w(19.0,pw), right: w(19,pw), bottom: h(8,ph)),
                          child: Text(
                              widget.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: w(24,pw),
                                  shadows: [
                                    Shadow(
                                        color: Colors.black,
                                        blurRadius: 4,
                                        offset: Offset(4, 4))
                                  ])),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: h(600,ph),
                width: double.infinity,
                margin: EdgeInsets.only(top: h(350,ph)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(52),
                      topRight: Radius.circular(52),
                    )),
                child: ListView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: h(30,ph),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.double_arrow,
                              color: Colors.grey,
                            ),
                            Text(
                              widget.cate,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: w(24,pw),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          fundatetime(widget.publish,0),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: w(19,pw),
                              color: Colors.deepOrange),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: h(20,ph), left: w(30,pw), right: w(18,pw)),
                      child: Text(
                        widget.desc,
                        style: TextStyle(
                            fontSize: w(19,pw), color: Colors.black.withOpacity(0.7)),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 15,
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(top: h(30.0,ph), right: w(35,pw)),
                          child: Text(
                            widget.name,
                            style: TextStyle(
                                fontSize: w(21,pw), fontWeight: FontWeight.w500,color: Colors.deepOrange),
                          ),
                        )),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: w(35.0,pw)),
                          child: Text(
                            fundatetime(widget.publish,1),
                            style: TextStyle(
                                fontSize: w(19,pw),
                                color: Colors.black.withOpacity(0.7)),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}