import 'package:githublist/const/field_master.dart';

class ModelUser{
  String sName = '';
  int iID = 0;
  String sNodeID = '';
  String sAvatarUrl = '';
  String sGravatarID = '';
  String sURL = '';
  String sHtmlURL = '';
  String sFollowersURL = '';
  String sFollowingURL = '';
  String sGistsURL = '';
  String sStarredURL = '';
  String sSubURL = '';
  String sOrgURL = '';
  String sReposURL = '';
  String sEventsURL = '';
  String sReceivedEventURL = '';
  String sType = '';
  bool bAdmin = false;

  void formJson(Map<String,dynamic> json){
    sName = json[Fields.sLogin] ?? '';
    iID = json[Fields.sID] ?? 0;
    sNodeID = json[Fields.sNodeID] ?? '';
    sAvatarUrl = json[Fields.sAvatarUrl] ?? '';
    sGravatarID = json[Fields.sGravatarID] ?? '';
    sURL = json[Fields.sURL] ?? '';
    sHtmlURL = json[Fields.sHtmlURL] ?? '';
    sFollowersURL = json[Fields.sFollowersURL] ?? '';
    sFollowingURL = json[Fields.sFollowingURL] ?? '';
    sGistsURL = json[Fields.sGistsURL] ?? '';
    sStarredURL = json[Fields.sStarredURL] ?? '';
    sSubURL = json[Fields.sSubURL] ?? '';
    sOrgURL = json[Fields.sOrgURL] ?? '';
    sReposURL = json[Fields.sReposURL] ?? '';
    sEventsURL = json[Fields.sEventsURL] ?? '';
    sReceivedEventURL = json[Fields.sReceivedEventURL] ?? '';
    sType = json[Fields.sType] ?? '';
    bAdmin = json[Fields.sAdmin] ?? false;
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> json = {};
    json[Fields.sLogin] = sName;
    json[Fields.sID] = iID;
    json[Fields.sNodeID] = sNodeID;
    json[Fields.sAvatarUrl] = sAvatarUrl;
    json[Fields.sGravatarID] = sGravatarID;
    json[Fields.sURL] = sURL;
    json[Fields.sHtmlURL] = sHtmlURL;
    json[Fields.sFollowersURL] = sFollowersURL;
    json[Fields.sFollowingURL] = sFollowingURL;
    json[Fields.sGistsURL] = sGistsURL;
    json[Fields.sStarredURL] = sStarredURL;
    json[Fields.sSubURL] = sSubURL;
    json[Fields.sOrgURL] = sOrgURL;
    json[Fields.sReposURL] = sReposURL;
    json[Fields.sEventsURL] = sEventsURL;
    json[Fields.sReceivedEventURL] = sReceivedEventURL;
    json[Fields.sType] = sType;
    json[Fields.sAdmin] = bAdmin;
    return json;
  }
}