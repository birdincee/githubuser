
import 'package:flutter/material.dart';
import 'package:githublist/model/model_user.dart';
import 'package:githublist/provider/user_list_provider.dart';
import 'package:githublist/utility/colors_main.dart';
import 'package:githublist/utility/font_thai.dart';
import 'package:provider/provider.dart';

class UserListMB extends StatelessWidget {
  const UserListMB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserListProvider>(
      builder: (context, prov, _) {
        if(prov.bFirst){
          return Scaffold(
            body: prov.widget.loadCenter(),
          );
        }else{
          Orientation orientation = MediaQuery.of(context).orientation;
          int maxCount = 0;
          if(orientation == Orientation.portrait){
            maxCount = 2;
          }else{
            maxCount = 4;
          }
          return Scaffold(
            appBar: AppBar(
              title: Row(
                children: [
                  prov.widget.logoApp(),
                  const Expanded(
                    child: Text('GitHub User'),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child:TextField(
                          controller: prov.txtSearch,
                          style: FontThai.text18WhiteNormal,
                          decoration: const InputDecoration(
                            hintText: 'Name',
                          ),
                          onChanged: (val)=> prov.onChangeSearch(),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: listItem(prov, maxCount)),
              ],
            ),
          );
        }
      },
    );
  }

  Widget listItem(UserListProvider prov,int maxCount) {
    if (prov.bLoadList) {
      return prov.widget.loadCenter();
    } else {
      if (prov.listShow.isEmpty) {
        return prov.widget.dataNotFond();
      } else {
        return Scrollbar(
          controller: prov.scrList,
          child: GridView.builder(
            shrinkWrap: true,
            controller: prov.scrList,
            itemCount: prov.listShow.length,
            padding: const EdgeInsets.all(8),
            physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: maxCount,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 150,
            ),
            itemBuilder: (_, index) {
              return buildItem(
                index: index,
                md: prov.listShow[index],
                prov: prov,
              );
            },
          ),
        );
      }
    }
  }

  Widget buildItem({
    required int index,
    required ModelUser md,
    required UserListProvider prov,
  }) {
    return Stack(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: ()=> prov.onPressDetail(md),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: double.infinity,
              child: Image.network(
                md.sAvatarUrl,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: ColorsSTD.cMain,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Tooltip(
                        message: md.sName,
                        child: RichText(
                          textAlign: TextAlign.start,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: 'Name : ',
                            style: FontThai.text16WhiteBold,
                            children: [
                              TextSpan(
                                text: md.sName,
                                style: FontThai.text16WhiteBold,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: ()=> prov.onTapUrl(md.sHtmlURL),
                          child: Tooltip(
                            message: md.sHtmlURL,
                            child: RichText(
                              textAlign: TextAlign.start,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: 'Url : ',
                                style: FontThai.text16WhiteBold,
                                children: [
                                  TextSpan(
                                    text: md.sHtmlURL,
                                    style: FontThai.text16BlueBold,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}