
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:githublist/provider/user_list_provider.dart';
import 'package:githublist/screen/user/user_list_mobile.dart';
import 'package:githublist/screen/user/user_list_web.dart';
import 'package:provider/provider.dart';

class UserListMain extends StatelessWidget {
  const UserListMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> UserListProvider(
          context: context,
        )),
      ],
      builder: (context,_){
        if(kIsWeb){
          return const UserListWeb();
        }else{
          return const UserListMB();
        }
      },
    );
  }
}
