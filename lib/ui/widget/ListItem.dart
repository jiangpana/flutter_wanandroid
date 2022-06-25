import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/data/db/table/Article.dart';

import '../../data/WanRepository.dart';

commonListItem(
    {required int id,
    String? title,
    String? shareUser,
    String? chapterName,
    String? niceDate,
    String? link,
    required Function itemClick}) {
  return InkWell(
    //按下去的颜色 或者说是说中状态的颜色
    highlightColor: Colors.transparent,
    //点击时的水波纹颜色
    splashColor: Colors.transparent,
    onTap: () {
      print(link);
      WanRepository().db.articleTable.insert(Article(
            id: id,
            title: title,
            shareUser: shareUser,
            chapterName: chapterName,
            niceDate: niceDate,
            link: link,
          ));
      itemClick.call();
    },
    child: Card(
      color: Colors.white,
      shadowColor: Colors.grey,
      elevation: 4,
      borderOnForeground: false,
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
      // 外边距
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                title ?? "",
                style: const TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                Flexible(
                    child: Text(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  "${shareUser ?? "官方"} , 分类: ${chapterName ?? ""}",
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                )),
                const SizedBox(
                  width: 8,
                ),
                const Icon(
                  Icons.access_time,
                  color: Colors.blue,
                ),
                Flexible(
                    child: Text(
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  niceDate ?? "",
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                ))
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
