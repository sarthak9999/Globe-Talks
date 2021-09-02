import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:our_news_app/Screens/screen2.dart';
import 'package:our_news_app/dataservice/dataservice.dart';
import 'package:our_news_app/models/article_model.dart';
import 'package:our_news_app/service/api.dart';

class Source extends StatefulWidget {

  final text;
  Source(this.text);

  @override
  _SourceState createState() => _SourceState();
}

class _SourceState extends State<Source> {

  final Dataservice dsvar=Get.find<Dataservice>();

  
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


  @override
  void initState() { 
    super.initState();
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown,DeviceOrientation.portraitUp,]
    );
  }

  ApiService client = ApiService();
  String query;
  String s1 = "http://newsapi.org/v2/everything?q=";
  String s2 = "&apiKey=1e5f1856fd144cc5898130425ce37a22";

  w(w1,pw){return pw*(w1/394);}
	h(h1,ph){return ph*(h1/851);}

  @override
  Widget build(BuildContext context) {
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
          widget.text.toString(),
          style: TextStyle(
              fontSize: 23, color: Colors.black, fontWeight: FontWeight.bold),
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
          _future('Breaking',(s1.toString()+widget.text.toString() + s2.toString()))
      ],
        ),
    );
  }


  Widget _future(cate,specific){
    var ph = Get.size.height;
    var pw = Get.size.width;
    return FutureBuilder(
                future: client.getNews(Uri.parse(specific)),
                        builder: (BuildContext context, AsyncSnapshot<List<NewsResponse>> snapshot) {
                          //let's check if we got a response or not
                          if (snapshot.hasData) {
                            //Now let's make a list of news
                            List<NewsResponse> news = snapshot.data;
                            return ListView.builder(physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return (news[index].urlToImage==null || news[index].title==null || news[index].description==null || news[index].publishedAt==null || news[index].author==null || news[index].source.name==null)?Container():
                    GestureDetector(
                              onTap: (){
                                Get.to(() => Screen2(news[index].urlToImage,news[index].title,news[index].description,'Breaking',news[index].source.name,news[index].publishedAt));
                              },
                              child: Card(
                                elevation: 6,
                                margin:
                                    EdgeInsets.only(left: w(5,pw), top: h(30,ph),),
                                shadowColor: Colors.black.withOpacity(0.7),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Container(height: h(250,ph),
                                  width: w(320,pw),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(news[index].urlToImage),
                                          fit: BoxFit.fill),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Container(
                                    width: w(320,pw),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.transparent,
                                              Colors.black.withOpacity(0.6)
                                            ]),
                                        borderRadius: BorderRadius.circular(12)),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsets.only(top: h(4.0,ph), right: h(4,ph)),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: ()async{
                                                var res = await Dataservice().funadd(dsvar.userauth.toString(),news[index].title,fundatetime(news[index].publishedAt,0),fundatetime(news[index].publishedAt,1),news[index].description,news[index].urlToImage,'Breaking',news[index].source.name,news[index].publishedAt,author:news[index].author);
                                                if(res[0]!=null){
                                                  funsnack('News Added','News added to your bookmarks',Colors.purpleAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
                                                }else{
                                                  funsnack('Error Occured',res[1].toString(),Colors.redAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
                                                }
                                              },
                                              child: Container(
                                                height: h(30,ph),
                                                width: w(30,pw),
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.white.withOpacity(1),
                                                    shape: BoxShape.circle),
                                                child: Icon(
                                                  Icons.bookmark_outline,
                                                  color: Colors.deepOrange,
                                                  size: w(24,pw),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: h(132,ph),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.symmetric(horizontal: w(8.0,pw)),
                                          child: Text(
                                            news[index].title,
                                            style: TextStyle(
                                                fontSize: w(20,pw),
                                                color: Colors.white,
                                                shadows: [
                                                  Shadow(
                                                      color: Colors.black.withOpacity(0.9),
                                                      blurRadius: 4,
                                                      offset: Offset(3, 3))
                                                ]),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
        
                  },
                  itemCount: news.length,
                  shrinkWrap: true,
                );
                          }
                        return Center(
                            child: SpinKitCircle(color: Colors.black,size: w(35,pw),),
                          );
                    });
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