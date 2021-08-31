import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:our_news_app/models/article_model.dart';
import 'package:our_news_app/screen2.dart';
import 'package:our_news_app/service/api.dart';

class Serach extends StatefulWidget {
  @override
  _SerachState createState() => _SerachState();
}

class _SerachState extends State<Serach> {

  w(w1,pw){return pw*(w1/392);}
	h(h1,ph){return ph*(h1/850);}

  ApiService client = ApiService();
  String query;
  bool showList = false;
  String s1 = "http://newsapi.org/v2/everything?q=";
  String s2 = "&apiKey=758b45cf50bf475cbd2f2ba76698bf96";

  @override
  Widget build(BuildContext context) {
    var ph = Get.size.height;
    var pw = Get.size.width;
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
        title: Text("Search ",
          style: TextStyle(fontSize: w(23,pw), fontWeight: FontWeight.bold, color: Colors.black),),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      body: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.all(w(20,pw)),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Flexible(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.all(w(8.0,pw)),
                    child: TextField(
                      onChanged: (value){setState(() {query = value;showList = true;});},
                      autofocus: true,
                      decoration: InputDecoration(hintText: "What's in your mind ?"),
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.all(w(8.0,pw)),
                    child: Center(child: Icon(Icons.search,size: w(34,pw),)),
                  ),
                ),
              ],
            ),
          ),
          showList?_future('Breaking',(s1.toString()+query + s2.toString())):Container()
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
                                  margin: EdgeInsets.all(w(8,pw)),
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
                                            child: Container()
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
                                        padding: EdgeInsets.all(w(6.0,pw)),
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