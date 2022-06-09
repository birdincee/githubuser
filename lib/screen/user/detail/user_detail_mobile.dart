
import 'package:flutter/material.dart';
import 'package:githublist/model/model_user.dart';
import 'package:githublist/provider/user_detail_provider.dart';
import 'package:githublist/utility/colors_main.dart';
import 'package:githublist/utility/font_thai.dart';
import 'package:provider/provider.dart';

class UserDetailMobile extends StatelessWidget {
  final ModelUser mdHead;
  const UserDetailMobile({
    Key? key,
    required this.mdHead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserDetailProv(
            context: context,
            mdHead: mdHead,
          ),
        ),
      ],
      builder: (context, _) {
        return Consumer<UserDetailProv>(
          builder: (BuildContext context, prov, _) {
            if(prov.bFirst){
              return Scaffold(
                body: prov.widget.loadCenter(),
              );
            }else{
              return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Row(
                    children: [
                      prov.widget.logoApp(),
                      const Expanded(
                        child: Text('Detail User'),
                      ),
                    ],
                  ),
                ),
                body: Scrollbar(
                  controller: prov.scrBody,
                  child: SingleChildScrollView(
                    controller: prov.scrBody,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        buildInfo(prov),
                        prov.widget.h5,
                        buildRepos(prov),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget buildInfo(UserDetailProv prov) {
    return Column(
      children: [
        prov.widget.h5,
        ClipOval(
          child: SizedBox(
            width: 200,
            height: 200,
            child: Image.network(
              prov.mdHead.sAvatarUrl,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.medium,
            ),
          ),
        ),
        prov.widget.h5,
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ColorsSTD.cMain,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Tooltip(
                      message: prov.mdHead.sName,
                      child: RichText(
                        textAlign: TextAlign.start,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: 'Name : ',
                          style: FontThai.text18WhiteBold,
                          children: [
                            TextSpan(
                              text: prov.mdHead.sName,
                              style: FontThai.text18WhiteBold,
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
                        onTap: () => prov.onTapUrl(prov.mdHead.sHtmlURL),
                        child: Tooltip(
                          message: prov.mdHead.sHtmlURL,
                          child: RichText(
                            textAlign: TextAlign.start,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: 'Url : ',
                              style: FontThai.text18WhiteBold,
                              children: [
                                TextSpan(
                                  text: prov.mdHead.sHtmlURL,
                                  style: FontThai.text18BlueBold,
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
      ],
    );
  }

  Widget buildRepos(UserDetailProv prov) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: ColorsSTD.cMain,
        border: Border.all(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                    onPressed: () => prov.onTapRepo(),
                    child: Text(
                      'Repositories Sync',
                      style: FontThai.text16WhiteBold,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ),
            ],
          ),
          prov.widget.h5,
          Row(
            children: [
              Expanded(
                child:TextField(
                  controller: prov.txtSearch,
                  style: FontThai.text18WhiteNormal,
                  decoration: const InputDecoration(
                    hintText: 'Name,Crated Date,Updated Date,Language',
                  ),
                  onChanged: (val)=> prov.onChangeSearch(),
                ),
              ),
            ],
          ),
          itemRepos(prov),
        ],
      ),
    );
  }

  Widget itemRepos(UserDetailProv prov){
    if(prov.bLoadList){
      return SizedBox(
        height: 200,
        child: prov.widget.loadCenter(),
      );
    }else{
      if(prov.listShow.isNotEmpty){
        return SizedBox(
          width: MediaQuery.of(prov.context).size.width,
          height: MediaQuery.of(prov.context).size.height / 3,
          child: Scrollbar(
            controller: prov.scrList,
            child: ListView.builder(
              controller: prov.scrList,
              physics: const BouncingScrollPhysics(),
              itemCount: prov.listShow.length,
              shrinkWrap: true,
              itemBuilder: (_,index){
                return prov.widget.itemExpansionMobile(
                  md: prov.listShow[index],
                  index: index,
                  onTapUrl: prov.onTapUrl,
                );
              },
            ),
          ),
        );
      }else{
        return SizedBox(
          height: 200,
          child: prov.widget.dataNotFond(),
        );
      }
    }
  }

}
