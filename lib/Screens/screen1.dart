import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:our_news_app/Login/login.dart';
import 'package:our_news_app/Screens/filter.dart';
import 'package:our_news_app/Screens/screen2.dart';
import 'package:our_news_app/Screens/screen3.dart';
import 'package:our_news_app/Screens/search.dart';
import 'package:our_news_app/dataservice/dataservice.dart';
import 'package:our_news_app/models/article_model.dart';
import 'package:our_news_app/service/api.dart';
import 'package:shimmer/shimmer.dart';


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() { 
    super.initState();
    dsvar.userauth(dsvar.userauth.toString());
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown,DeviceOrientation.portraitUp,]
    );
  }


  final Dataservice dsvar=Get.find<Dataservice>();

  ApiService client = ApiService();

  String s1 = "http://newsapi.org/v2/everything?q=";
  String s2 = "&apiKey=1e5f1856fd144cc5898130425ce37a22";
  int selectedicon = 0;
    w(w1,pw){return pw*(w1/394);}
	h(h1,ph){return ph*(h1/851);}
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
  Widget build(BuildContext context) {
    var pw=Get.size.width;
    var ph=Get.size.height;

    print('$pw pw');
    print('$ph ph');
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,showUnselectedLabels: false,currentIndex: selectedicon,selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black.withOpacity(0.5),
          onTap: (value){
            setState(() 
            {
            selectedicon=value;
             if (selectedicon==0){Navigator.push(context, MaterialPageRoute(builder: (context)=>Screen3()));}
            else if (selectedicon==1){Navigator.push(context, MaterialPageRoute(builder: (context)=>Filter()));}
            else if (selectedicon==2){Navigator.push(context, MaterialPageRoute(builder: (context)=>Serach()));}
            });
          },
          items: [  
            BottomNavigationBarItem(icon: Icon(Icons.bookmark,size: w(30,pw),color: Colors.orange,),label:"BookMark" ),
            BottomNavigationBarItem(icon: Icon(Icons.filter_list_outlined,color: Colors.purple,size:w(30,pw)),label:"Filter" ),
            BottomNavigationBarItem(icon: Icon(Icons.search,size: w(30,pw),color: Colors.deepOrange,),label:"Search" ), 
          ]
          ),
        body: NestedScrollView(
          headerSliverBuilder: (context, bool) {
            return [
              SliverAppBar(
                forceElevated: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                titleSpacing: 0,
                leadingWidth: 0,
                toolbarHeight: h(510,ph),
                elevation: 10,
                shadowColor: Colors.black.withOpacity(0.7),
                backgroundColor: Colors.white.withOpacity(0.95),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: h(30,ph),
                    ),
                    Container(
                      height: h(66,ph),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.pink.withOpacity(0.7),
                              Colors.orange.withOpacity(0.8),
                            ]),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: w(50,pw),
                          ),
                          Text(
                            "Globe Talks",
                            style: TextStyle(
                                fontSize: w(30,pw),
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: w(30,pw),
                          ),
                          IconButton(
                              onPressed: () async{
                                dsvar.userauth('');
                                await FirebaseAuth.instance.signOut();
                                funsnack('Thank you ! ',"Thank you for being a user of Globe Talks  ",Colors.purple,Icons.favorite,30.0,0.0,20.0,10.0,10.0);
                                Future.delayed(Duration(milliseconds: 1500),(){
                                  Get.to(()=>Mood());
                                });
                                
                              },
                              icon: Icon(
                                Icons.power_settings_new,
                                size: w(28,pw),
                                color: Colors.white,
                              )),
                        ],
                      ),),
                    Padding(
                      padding: EdgeInsets.only(left: w(18.0,pw), top: h(20,ph)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Shimmer.fromColors(
                          highlightColor: Colors.grey,
                          baseColor: Colors.black,
                          child: Text(
                            "Breaking news",
                            style: TextStyle(
                              fontSize: w(28,pw),
                                fontWeight: FontWeight.w800,
                                color: Colors.black.withOpacity(0.7),
                                shadows: [
                                  Shadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 4,
                                      offset: Offset(3, 3))
                                ]),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: h(230,ph),
                      child: FutureBuilder(
                        future: client.getNews("http://newsapi.org/v2/top-headlines?q=a&apiKey=1e5f1856fd144cc5898130425ce37a22"),
                        builder: (BuildContext context, AsyncSnapshot<List<NewsResponse>> snapshot) {
                          //let's check if we got a response or not
                          if (snapshot.hasData) {
                            //Now let's make a list of news
                            List<NewsResponse> news = snapshot.data;
                            return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return (news[index].urlToImage==null || news[index].title==null || news[index].description==null || news[index].publishedAt==null || news[index].author==null || news[index].source.name==null)?Container():
                            GestureDetector(
                              onTap: (){
                                Get.to(() => Screen2(news[index].urlToImage,news[index].title,news[index].description,'Breaking',news[index].source.name,news[index].publishedAt));
                              },
                              child: Card(
                                elevation: 6,
                                margin:
                                    EdgeInsets.only(left: w(20,pw), top: h(10,ph), bottom: h(10,ph)),
                                shadowColor: Colors.black.withOpacity(0.7),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Container(
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
                                          height: h(112,ph),
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
                        },
                      ),
                    ),
                    SizedBox(
                      height: h(10,ph),
                    ),
                    Row(
                      children: [
                        Expanded(
                            flex: 6,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '  Discover',
                                    style: TextStyle(
                                        fontSize: w(31,pw),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '   Around all the globe.',
                                    style: TextStyle(
                                        fontSize: w(18,pw),
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black.withOpacity(0.6)),
                                  ),
                                ),
                              ],
                            )),
                        Expanded(
                            flex: 4,
                            child: Container(
                              height: h(135,ph),
                              width: w(135,ph),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.orangeAccent.withOpacity(0.2),
                                        offset: Offset(1, 1),
                                        blurRadius: 2)
                                  ],
                              ),
                              child: Lottie.asset(
                                'animations/news.json',fit: BoxFit.contain
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: h(40,ph),
                    ),
                  ],
                ),
                bottom: TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Colors.black,
                  labelPadding: EdgeInsets.symmetric(horizontal: w(20,pw)),
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.black.withOpacity(0.8),
                  tabs: [
                    Tab(
                        child: Text('Business',
                            style: TextStyle(
                              fontSize: w(21,pw),
                            ))),
                    Tab(
                      child: Text('Health',
                          style: TextStyle(
                            fontSize: w(21,pw),
                          )),
                    ),
                    Tab(
                      child: Text('Politics',
                          style: TextStyle(
                            fontSize: w(21,pw),
                          )),
                    ),
                    Tab(
                      child: Text('Food',
                          style: TextStyle(
                            fontSize: w(21,pw),
                          )),
                    ),
                    Tab(
                      child: Text('Fashion',
                          style: TextStyle(
                            fontSize: w(21,pw),
                          )),
                    ),
                    Tab(
                      child: Text('Sports',
                          style: TextStyle(
                            fontSize: w(21,pw),
                          )),
                    ),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            physics: ClampingScrollPhysics(),
            children: [
              _future("Business",(s1+"Business" + s2).toString()),
              _future("Health",  (s1 + "Health" + s2).toString()),
              _future("Politics",(s1 + "Politics"+ s2).toString()),
              _future("Food",    (s1 + "Food"+ s2).toString()),
              _future("Fashion", (s1 + "Fashion"+ s2).toString()),
              _future("Sport",   (s1 + "Sport"+ s2).toString()),
            ],
          ),
        ),
      ),
    );
  }

  

  Widget _future(cate,specific){
    var pw = Get.size.width;
    var ph = Get.size.height;
    return FutureBuilder(
                future: client.getNews(Uri.parse(specific)),
                        builder: (BuildContext context, AsyncSnapshot<List<NewsResponse>> snapshot) {
                          //let's check if we got a response or not
                          if (snapshot.hasData) {
                            //Now let's make a list of news
                            List<NewsResponse> news = snapshot.data;
                            return ListView.builder(
                  itemBuilder: (context, index) {
                    return (news[index].urlToImage==null || news[index].title==null || news[index].description==null || news[index].publishedAt==null || news[index].author==null || news[index].source.name==null)?Container():
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      margin: EdgeInsets.only(
                          top: h(15,ph), left: w(20,pw), right: w(20,pw), bottom: h(15,ph)),
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
                            Flexible(
                              flex: 4,
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => Screen2(news[index].urlToImage,news[index].title,news[index].description,cate,news[index].source.name,news[index].publishedAt));
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
                                            image: NetworkImage(news[index].urlToImage),
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
                                      padding: EdgeInsets.only(
                                          top: h(16.0,ph), left: w(4,pw), right: w(4,pw)),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 15,
                                            child: Text(
                                              news[index].source.name.capitalizeFirst,
                                              style: TextStyle(
                                                  fontSize: w(15,pw),
                                                  color: Colors.deepOrange
                                                      .withOpacity(1),
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: GestureDetector(
                                              onTap: ()async{
                                                var res = await Dataservice().funadd(dsvar.userauth.toString(),news[index].title,fundatetime(news[index].publishedAt,0),fundatetime(news[index].publishedAt,1),news[index].description,news[index].urlToImage,'Breaking',news[index].source.name,news[index].publishedAt,author:news[index].author);
                                                if(res[0]!=null){
                                                  funsnack('News Added','News added to your bookmarks',Colors.purpleAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
                                                }else{
                                                  funsnack('Error Occured',res[1].toString(),Colors.redAccent,Icons.info_outline,30.0,0.0,20.0,10.0,10.0);
                                                }
                                              },
                                              child: Icon(
                                                Icons.bookmark_outline,
                                                color: Colors.black,
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
                                        Get.to(() => Screen2(news[index].urlToImage,news[index].title,news[index].description,cate,news[index].source.name,news[index].publishedAt));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(6.0),
                                        child: Text(
                                          news[index].title,
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
                          ],
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