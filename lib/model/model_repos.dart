
import 'package:githublist/const/field_master.dart';
import 'package:githublist/model/model_user.dart';

class ModelRepos{
  int iID = 0;
  String sNodeID = '';
  String sName = '';
  String sFullName = '';
  bool bPrivate = false;
  ModelUser owner = ModelUser();
  String sURL = '';
  String sHtmlURL = '';
  String sCreatedAt = '';
  String sUpdatedAt = '';
  String sPushAt = '';
  String sCloneURL = '';
  String sLanguage = '';
  int iWatcher = 0;

  void formJson(Map<String,dynamic> json){
    iID = json[Fields.sID] ?? 0;
    sNodeID = json[Fields.sNodeID] ?? '';
    sName = json[Fields.sName] ?? '';
    sFullName = json[Fields.sName] ?? '';
    bPrivate = json[Fields.sPrivate] ?? false;
    Map<String,dynamic> mOwner = json[Fields.sOwner] ?? {};
    owner.formJson(mOwner);
    sURL = json[Fields.sURL] ?? '';
    sHtmlURL = json[Fields.sHtmlURL] ?? '';
    sCreatedAt = json[Fields.sCreatedAt] ?? '';
    sUpdatedAt = json[Fields.sUpdatedAt] ?? '';
    sPushAt = json[Fields.sPushAt] ?? '';
    sCloneURL = json[Fields.sCloneURL] ?? '';
    sLanguage = json[Fields.sLanguage] ?? '';
    iWatcher = json[Fields.sWatcher] ?? 0;
  }
}