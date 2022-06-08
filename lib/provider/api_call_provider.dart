
import 'dart:collection';
import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:githublist/database/user_db.dart';
import 'package:githublist/model/model_repos.dart';
import 'package:githublist/model/model_user.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class ApiCallProv with ChangeNotifier{

  Future<List<ModelUser>> getDataUser()async{
    // Uri uri = Uri.parse('https://api.github.com/users');
    var url = Uri(
      scheme: 'http',
      host: 'api.github.com',
      path: 'users',
    );
    var response = await http.get(url,
      headers: {
      'Accept' : 'application/vnd.github.v3+json',
      },
    );
    var data = convert.jsonDecode(response.body);
    List<ModelUser> list = [];
    if(response.statusCode == 200){
      UserDB db = UserDB();
      await db.initDB();
      for(var temp in data){
        Map<String,dynamic> map = HashMap.from(temp);
        ModelUser md = ModelUser();
        md.formJson(map);
        list.add(md);
        await db.putData(key: md.sNodeID, map: md.toJson());
      }
      list.sort((a, b) => a.iID.compareTo(b.iID),);
      if(kDebugMode){
        print(list.length);
      }
    }
    return list;
  }

  Future<List<ModelRepos>> getDataRepo(String sUrl)async{
    Uri uri = Uri.parse(sUrl);
    var response = await http.get(uri,
      headers: {
        'Accept' : 'application/vnd.github.v3+json',
      },
    );
    var data = convert.jsonDecode(response.body);
    List<ModelRepos> list = [];
    if(response.statusCode == 200){
      for(var temp in data){
        Map<String,dynamic> map = HashMap.from(temp);
        ModelRepos md = ModelRepos();
        md.formJson(map);
        list.add(md);
      }
      list.sort((a, b) => a.sCreatedAt.compareTo(b.sCreatedAt),);
      if(kDebugMode){
        print(list.length);
      }
    }
    return list;
  }

  void onTapUrl(String sUrl) async {
    final Uri url = Uri.parse(sUrl);
    if (!await launchUrl(url)) throw 'Could not launch $url';
  }

}