import 'package:flutter/material.dart';
import 'package:githublist/model/model_user.dart';
import 'package:githublist/provider/user_detail_provider.dart';
import 'package:githublist/utility/colors_main.dart';
import 'package:githublist/utility/font_thai.dart';
import 'package:provider/provider.dart';

class DialogUserDetail {
  final BuildContext context;

  DialogUserDetail({
    required this.context,
  });

  Future<dynamic> open({
    required ModelUser mdHead,
  }) {
    return showDialog(
      context: context,
      builder: (_) {
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
            return const _FormDialog();
          },
        );
      },
    );
  }
}

class _FormDialog extends StatelessWidget {
  const _FormDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailProv>(
      builder: (context, prov, _) {
        if (prov.bFirst) {
          return AlertDialog(
            backgroundColor: ColorsSTD.cBG,
            content: SingleChildScrollView(
              child: prov.widget.loadCenter(),
            ),
          );
        } else {
          return LayoutBuilder(
            builder: (context, constraints) {
              if(constraints.maxWidth > constraints.maxHeight){
                return _webDesktop(prov);
              }else{
                return _webMobile(prov);
              }
            },
          );
        }
      },
    );
  }

  Widget _webDesktop(UserDetailProv prov){
    return AlertDialog(
      backgroundColor: ColorsSTD.cBG,
      titlePadding: const EdgeInsets.all(10),
      title: Row(
        children: [
          prov.widget.logoApp(),
          Expanded(
            child: Text(
              'Detail User',
              style: FontThai.text18WhiteBold,
            ),
          ),
        ],
      ),
      content: Scrollbar(
        controller: prov.scrBody,
        child: SingleChildScrollView(
          controller: prov.scrBody,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: buildInfo(prov),
              ),
              prov.widget.w5,
              Expanded(
                flex: 5,
                child: buildRepos(prov,false),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => prov.onTapBack(),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
          ),
          child: Text(
            'Close',
            style: FontThai.text16BlackNormal,
          ),
        ),
      ],
    );
  }

  Widget _webMobile(UserDetailProv prov){
    return AlertDialog(
      backgroundColor: ColorsSTD.cBG,
      titlePadding: const EdgeInsets.all(10),
      title: Row(
        children: [
          prov.widget.logoApp(),
          Expanded(
            child: Text(
              'Detail User',
              style: FontThai.text18WhiteBold,
            ),
          ),
        ],
      ),
      content: Scrollbar(
        controller: prov.scrBody,
        child: SingleChildScrollView(
          controller: prov.scrBody,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              buildInfo(prov),
              prov.widget.h5,
              buildRepos(prov,true),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => prov.onTapBack(),
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
          ),
          child: Text(
            'Close',
            style: FontThai.text16BlackNormal,
          ),
        ),
      ],
    );
  }

  Widget buildInfo(UserDetailProv prov) {
    return Column(
      children: [
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
        prov.widget.h10,
        Container(
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

  Widget buildRepos(UserDetailProv prov,bool bMobile) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  child: ElevatedButton(
                    onPressed: () => prov.onTapRepo(),
                    child: Text(
                      'Repositories Sync',
                      style: FontThai.text16WhiteBold,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )),
              prov.widget.w5,
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
          itemRepos(prov,bMobile),
        ],
      ),
    );
  }

  Widget itemRepos(UserDetailProv prov,bool bMobile){
    if(prov.bLoadList){
      return SizedBox(
        height: 400,
        child: prov.widget.loadCenter(),
      );
    }else{
      if(prov.listShow.isNotEmpty){
        double width = 0.0;
        if(bMobile){
          width = MediaQuery.of(prov.context).size.width;
        }else{
          width = MediaQuery.of(prov.context).size.width / 3;
        }
        return SizedBox(
          width: width,
          height: 400,
          child: Scrollbar(
            controller: prov.scrList,
            child: ListView.builder(
              controller: prov.scrList,
              physics: const BouncingScrollPhysics(),
              itemCount: prov.listShow.length,
              shrinkWrap: true,
              itemBuilder: (_,index){
                if(bMobile){
                  return prov.widget.itemExpansionMobile(
                    md: prov.listShow[index],
                    index: index,
                    onTapUrl: prov.onTapUrl,
                  );
                }else{
                  return prov.widget.itemExpansionDesktop(
                    md: prov.listShow[index],
                    index: index,
                    onTapUrl: prov.onTapUrl,
                  );
                }
              },
            ),
          ),
        );
      }else{
        return SizedBox(
          height: 400,
          child: prov.widget.dataNotFond(),
        );
      }
    }
  }


}
