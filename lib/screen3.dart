import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:our_news_app/dataservice.dart';
import 'package:our_news_app/screen2.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class Screen3 extends StatefulWidget {
  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {

    w(w1,pw){return pw*(w1/392);}
	h(h1,ph){return ph*(h1/850);}
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
    var pw = Get.size.width; 
    var ph = Get.size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        shadowColor: Colors.black.withOpacity(0.7),
        backgroundColor: Colors.white.withOpacity(0.85),
        title: Text(
          "Bookmarks",
          style: TextStyle(
              fontSize: w(23,pw), fontWeight: FontWeight.bold, color: Colors.black),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      body: 
      PaginateFirestore(
        shrinkWrap: true,physics: ClampingScrollPhysics(),
        itemBuilder: (index,context,ds){
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: EdgeInsets.only(top: h(20,ph), left: w(20,pw), right: w(20,pw), bottom: h(5,ph)),
            elevation: 5,
            shadowColor: Colors.black.withOpacity(0.7),
            child: Container(
              height: h(165,ph),
              width: w(300,pw),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  index % 2 != 0
                      ? Container()
                      : Flexible(
                          flex: 4,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => Screen2(ds['url'],ds['title'],ds['desc'],ds['cate'],ds['name'],ds['publish']));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              margin: EdgeInsets.all(8),
                              elevation: 5,
                              shadowColor: Colors.black.withOpacity(0.7),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(ds['url']),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                        ),
                  Flexible(
                    flex: 6,
                    child: Column(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding:
                                EdgeInsets.only(top: h(16.0,ph), left: w(4,pw), right: w(4,pw)),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 15,
                                  child: Text(
                                    ds['name'],
                                    style: TextStyle(
                                        fontSize: w(15,pw),
                                        color: Colors.deepOrange.withOpacity(1),
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: GestureDetector(
                                    onTap: ()async{
                                      var res = await Dataservice().funremove(ds.id);
                                      if(res[0]!=null){
                                        funsnack('News Deleted','News deleted from your bookmarks',Colors.purpleAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
                                      }else{
                                        funsnack('Error Occured',res[1].toString(),Colors.redAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
                                      }
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.redAccent,
                                      size: w(24,pw),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 7,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => Screen2(ds['url'],ds['title'],ds['desc'],ds['cate'],ds['name'],ds['publish']));                            },
                            child: Padding(
                              padding: EdgeInsets.all(w(6,pw)),
                              child: Text(
                                ds['title'],
                                style: TextStyle(
                                  fontSize: w(17,pw),
                                  color: Colors.black.withOpacity(0.7),
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  index % 2 == 0
                      ? Container()
                      : Flexible(
                          flex: 4,
                          child: GestureDetector(
                            onTap: () {
                              Get.to(() => Screen2(ds['url'],ds['title'],ds['desc'],ds['cate'],ds['name'],ds['publish']));
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              margin: EdgeInsets.all(8),
                              elevation: 5,
                              shadowColor: Colors.black.withOpacity(0.7),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(ds['url']),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
        query: FirebaseFirestore.instance.collection('Bookmarks'),
        itemBuilderType: PaginateBuilderType.listView,
        initialLoader: SpinKitCircle(color: Colors.black,size:30,),
        emptyDisplay: Center(child: Column(mainAxisAlignment : MainAxisAlignment.center,
          children: [
            Container(child:Icon(Icons.subtitles_off,size:120,color:Colors.orange)),
            Text('No bookmarks',style:TextStyle(fontSize: 24,color:Colors.pink))
          ],
        )),
        isLive: true,
      ),
    );
  }
}