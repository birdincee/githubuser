
import 'package:flutter/material.dart';
import 'package:githublist/const/functions.dart';
import 'package:githublist/model/model_repos.dart';
import 'package:githublist/utility/font_thai.dart';

class StandardWidget{

  final SizedBox h10 = const SizedBox(
    height: 10,
  );
  final SizedBox h5 = const SizedBox(
    height: 5,
  );

  final SizedBox w5 = const SizedBox(
    width: 5,
  );

  final SizedBox w3 = const SizedBox(
    width: 3,
  );

  final EdgeInsets edgeAll8 = const EdgeInsets.all(8.0);

  final Duration duration200m = const Duration(milliseconds: 200);

  Widget logoApp(){
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(3),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        'assets/img/gitlogo.png',
        fit: BoxFit.cover,
        filterQuality: FilterQuality.medium,
      ),
    );
  }

  Widget loadCenter(){
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget dataNotFond(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: Text('ไม่พบข้อมูล',
            style: FontThai.text30WhiteBold,
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Widget itemExpansionDesktop({
    required ModelRepos md,
    required int index,
    required Function(String) onTapUrl,
  }){
    String sCreate = Functions.convertDate(md.sCreatedAt);
    String sUpdate = Functions.convertDate(md.sUpdatedAt);
    String sPush = Functions.convertDate(md.sPushAt);
    String sPrivate = '';
    if(md.bPrivate){
      sPrivate = 'Yes';
    }else{
      sPrivate = 'No';
    }
    return ExpansionTile(
      leading: Text(
        '${index+1}',
        style: FontThai.text18WhiteBold,
      ),
      title: Row(
        children: [
          Expanded(
            flex: 8,
            child: Tooltip(
              message: md.sFullName,
              child: RichText(
                textAlign: TextAlign.start,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: 'FullName : ',
                  style: FontThai.text18WhiteBold,
                  children: [
                    TextSpan(
                      text: md.sFullName,
                      style: FontThai.text18WhiteBold,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                const SizedBox(
                  width: 30,
                  child: Icon(Icons.remove_red_eye_sharp,
                    color: Colors.white,
                  ),
                ),
                w5,
                Expanded(
                  child: Text(
                    '${md.iWatcher}',
                    style: FontThai.text18BlueBold,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Tooltip(
              message: sCreate,
              child: RichText(
                textAlign: TextAlign.start,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: 'Created Date : ',
                  style: FontThai.text16WhiteBold,
                  children: [
                    TextSpan(
                      text: sCreate,
                      style: FontThai.text16WhiteBold,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      childrenPadding: const EdgeInsets.all(10),
      children: [
        Row(
          children: [
            Expanded(
              child: Tooltip(
                message: sPush,
                child: RichText(
                  textAlign: TextAlign.start,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Pushed Date : ',
                    style: FontThai.text16WhiteBold,
                    children: [
                      TextSpan(
                        text: sPush,
                        style: FontThai.text16WhiteBold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            w5,
            Expanded(
              child: Tooltip(
                message: sUpdate,
                child: RichText(
                  textAlign: TextAlign.start,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Updated Date : ',
                    style: FontThai.text16WhiteBold,
                    children: [
                      TextSpan(
                        text: sUpdate,
                        style: FontThai.text16WhiteBold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        h5,
        Row(
          children: [
            Expanded(
              child: Tooltip(
                message: md.sLanguage,
                child: RichText(
                  textAlign: TextAlign.start,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Language : ',
                    style: FontThai.text16WhiteBold,
                    children: [
                      TextSpan(
                        text: md.sLanguage,
                        style: FontThai.text16WhiteBold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            w5,
            Expanded(
              child: Tooltip(
                message: sPrivate,
                child: RichText(
                  textAlign: TextAlign.start,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Private : ',
                    style: FontThai.text16WhiteBold,
                    children: [
                      TextSpan(
                        text: sPrivate,
                        style: FontThai.text16WhiteBold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        h5,
        Row(
          children: [
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: ()=> onTapUrl(md.sHtmlURL),
                  child: Tooltip(
                    message: md.sHtmlURL,
                    child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: 'Url : ',
                        style: FontThai.text18WhiteBold,
                        children: [
                          TextSpan(
                            text: md.sHtmlURL,
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
        h5,
        Row(
          children: [
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: ()=> onTapUrl(md.sCloneURL),
                  child: Tooltip(
                    message: md.sCloneURL,
                    child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: 'Clone Url : ',
                        style: FontThai.text18WhiteBold,
                        children: [
                          TextSpan(
                            text: md.sCloneURL,
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
    );
  }

  Widget itemExpansionMobile({
    required ModelRepos md,
    required int index,
    required Function(String) onTapUrl,
  }){
    String sCreate = Functions.convertDate(md.sCreatedAt);
    String sUpdate = Functions.convertDate(md.sUpdatedAt);
    String sPush = Functions.convertDate(md.sPushAt);
    String sPrivate = '';
    if(md.bPrivate){
      sPrivate = 'Yes';
    }else{
      sPrivate = 'No';
    }
    return ExpansionTile(
      leading: Text(
        '${index+1}',
        style: FontThai.text18WhiteBold,
      ),
      title: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 8,
                child: Tooltip(
                  message: md.sFullName,
                  child: RichText(
                    textAlign: TextAlign.start,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: 'FullName : ',
                      style: FontThai.text18WhiteBold,
                      children: [
                        TextSpan(
                          text: md.sFullName,
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
                flex: 2,
                child: Row(
                  children: [
                    const Icon(Icons.remove_red_eye_sharp,
                      color: Colors.white,
                    ),
                    w5,
                    Expanded(
                      child: Text(
                        '${md.iWatcher}',
                        style: FontThai.text18BlueBold,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Tooltip(
              message: sCreate,
              child: RichText(
                textAlign: TextAlign.start,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: 'Created Date : ',
                  style: FontThai.text16WhiteBold,
                  children: [
                    TextSpan(
                      text: sCreate,
                      style: FontThai.text16WhiteBold,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      childrenPadding: const EdgeInsets.all(10),
      children: [
        Row(
          children: [
            Expanded(
              child: Tooltip(
                message: sPush,
                child: RichText(
                  textAlign: TextAlign.start,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Pushed Date : ',
                    style: FontThai.text16WhiteBold,
                    children: [
                      TextSpan(
                        text: sPush,
                        style: FontThai.text16WhiteBold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        h5,
        Row(
          children: [
            Expanded(
              child: Tooltip(
                message: sUpdate,
                child: RichText(
                  textAlign: TextAlign.start,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Updated Date : ',
                    style: FontThai.text16WhiteBold,
                    children: [
                      TextSpan(
                        text: sUpdate,
                        style: FontThai.text16WhiteBold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        h5,
        Row(
          children: [
            Expanded(
              child: Tooltip(
                message: md.sLanguage,
                child: RichText(
                  textAlign: TextAlign.start,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Language : ',
                    style: FontThai.text16WhiteBold,
                    children: [
                      TextSpan(
                        text: md.sLanguage,
                        style: FontThai.text16WhiteBold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            w5,
            Expanded(
              child: Tooltip(
                message: sPrivate,
                child: RichText(
                  textAlign: TextAlign.start,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Private : ',
                    style: FontThai.text16WhiteBold,
                    children: [
                      TextSpan(
                        text: sPrivate,
                        style: FontThai.text16WhiteBold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        h5,
        Row(
          children: [
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: ()=> onTapUrl(md.sHtmlURL),
                  child: Tooltip(
                    message: md.sHtmlURL,
                    child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: 'Url : ',
                        style: FontThai.text18WhiteBold,
                        children: [
                          TextSpan(
                            text: md.sHtmlURL,
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
        h5,
        Row(
          children: [
            Expanded(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: ()=> onTapUrl(md.sCloneURL),
                  child: Tooltip(
                    message: md.sCloneURL,
                    child: RichText(
                      textAlign: TextAlign.start,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: 'Clone Url : ',
                        style: FontThai.text18WhiteBold,
                        children: [
                          TextSpan(
                            text: md.sCloneURL,
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
    );
  }
}