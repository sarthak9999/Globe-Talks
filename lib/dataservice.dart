import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as Path;

class Dataservice extends GetxController{


  final FirebaseFirestore _fs=FirebaseFirestore.instance;


  var signinshop=false.obs;
  var sendingreset=false.obs;

  funadd(title, date, time, desc, url, cate,name,publish,{author}) async {
    try {
      await _fs.collection("Bookmarks").add({
        'title': title,
        'date': date,
        'time': time,
        'desc': desc,
        'url': url,
        'cate': cate,
        'name': name,
        'author':author,
        'publish':publish
      });
      return ['done'];
    } catch (e) {
      return [null, e.code];
    }
  }

  funremove(id) async {
    try {
      await _fs
          .collection("Bookmarks")
          .doc(id)
          .delete();
      return ['done'];
    } catch (e) {
      return [null, e.code];
    }
  }

}