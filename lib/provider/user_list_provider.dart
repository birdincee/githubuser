import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:githublist/database/user_db.dart';
import 'package:githublist/model/model_user.dart';
import 'package:githublist/provider/api_call_provider.dart';
import 'package:githublist/screen/user/detail/dialog_user_detail_web.dart';
import 'package:githublist/utility/std_widget.dart';

class UserListProvider extends ApiCallProv {

  final BuildContext context;

  UserListProvider({
    required this.context,
  }) {
    initProv();
  }

  bool bFirst = true;
  bool bLoadList = true;
  StandardWidget widget = StandardWidget();

  List<ModelUser> listData = [];
  List<ModelUser> listShow = [];

  late ScrollController scrList;

  TextEditingController txtSearch = TextEditingController();

  initProv() async {
    scrList = ScrollController(initialScrollOffset: 0);
    await setDataUser();
    bFirst = false;
    bLoadList = false;
    notifyListeners();
  }

  Future<void> setDataUser() async {
    UserDB db = UserDB();
    listData = await db.getAllData();
    if (listData.isEmpty) {
      listData = await getDataUser();
    }
    await filterData();
  }

  Future<void> filterData() async {
    if (listData.isNotEmpty) {
      for (var m in listData) {
        if (txtSearch.text.isNotEmpty) {
          String sText = txtSearch.text;
          if (m.sName.toLowerCase().contains(sText.toLowerCase())) {
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

  void onPressDetail(ModelUser mdHead)async{
    if(kIsWeb){
      DialogUserDetail(context: context).open(mdHead: mdHead);
    }else{

    }
  }
}
