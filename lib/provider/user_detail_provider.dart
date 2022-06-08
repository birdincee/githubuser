
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:githublist/model/model_repos.dart';
import 'package:githublist/model/model_user.dart';
import 'package:githublist/provider/api_call_provider.dart';
import 'package:githublist/utility/std_widget.dart';

class UserDetailProv extends ApiCallProv{
  final BuildContext context;
  final ModelUser mdHead;

  UserDetailProv({
    required this.context,
    required this.mdHead,
  }){
    initProv();
  }

  bool bFirst = true;
  bool bLoadList = false;
  StandardWidget widget = StandardWidget();

  late ScrollController scrBody;
  late ScrollController scrList;

  List<ModelRepos> listData = [];
  List<ModelRepos> listShow = [];
  TextEditingController txtSearch = TextEditingController();

  initProv()async{
    // if(kDebugMode){
    //   print(jsonEncode(mdHead.toJson()));
    // }
    scrBody = ScrollController(initialScrollOffset: 0);
    scrList = ScrollController(initialScrollOffset: 0);
    bFirst = false;
    notifyListeners();
  }

  onTapBack(){
    Navigator.pop(context);
  }

  onTapRepo()async{
    bLoadList = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 800),(){
      listData.clear();
    });
    listData = await getDataRepo(mdHead.sReposURL);
    await filterData();
    bLoadList = false;
    notifyListeners();
  }

  Future<void> filterData() async {
    if (listShow.isEmpty) {
      for (var m in listData) {
        if (txtSearch.text.isNotEmpty) {
          String sText = txtSearch.text;
          if (m.sName.toLowerCase().contains(sText.toLowerCase())) {
            listShow.add(m);
          }else if(m.sFullName.toLowerCase().contains(sText.toLowerCase())){
            listShow.add(m);
          }else if(m.sCreatedAt.toLowerCase().contains(sText.toLowerCase())){
            listShow.add(m);
          }else if(m.sUpdatedAt.toLowerCase().contains(sText.toLowerCase())){
            listShow.add(m);
          }else if(m.sLanguage.toLowerCase().contains(sText.toLowerCase())){
            listShow.add(m);
          }
        } else {
          listShow.add(m);
        }
      }
    }
  }

  void onChangeSearch()async{
    listShow.clear();
    await filterData();
    notifyListeners();
  }
}