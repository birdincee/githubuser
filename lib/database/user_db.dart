import 'dart:collection';

import 'package:githublist/model/model_user.dart';
import 'package:hive/hive.dart';

class UserDB {
  final String sName = 'user_db';
  late Box box;

  Future<void> initDB() async {
    box = await Hive.openBox(sName);
  }

  Future<void> putData({
    required String key,
    required Map<String, dynamic> map,
  }) async {
    await box.put(key, map);
  }

  Future<List<ModelUser>> getAllData()async{
    await initDB();
    List<ModelUser> list = [];
    if(box.isNotEmpty){
      for(int i = 0;i<box.length;i++){
        dynamic temp = box.getAt(i);
        Map<String,dynamic> map = HashMap.from(temp);
        ModelUser md = ModelUser();
        md.formJson(map);
        list.add(md);
      }
      list.sort((a, b) => a.iID.compareTo(b.iID),);
    }
    return list;
  }

}
