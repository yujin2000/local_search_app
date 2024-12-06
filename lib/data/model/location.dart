// {
//   "title": "삼성1동 주민센터",
//   "link": "http://www.gangnam.go.kr/center/main.do?office=3220047",
//   "category": "공공,사회기관>행정복지센터",
//   "description": "",
//   "telephone": "",
//   "address": "서울특별시 강남구 삼성1동 161-2",
//   "roadAddress": "서울특별시 강남구 봉은사로 616 삼성1동 주민센터",
//   "mapx": "1270625320",
//   "mapy": "375144424"
// },

import 'package:local_search_app/core/html_tag_util.dart';

class Location {
  String title;
  String link;
  String category;
  String roadAddress;

  Location({
    required this.title,
    required this.link,
    required this.category,
    required this.roadAddress,
  });

  /// Map 형식의 json 데이터를 객체로 변환
  Location.fromJson(Map<String, dynamic> map)
      : this(
          title: HtmlTagUtil.replace(map['title']),
          link: map['link'],
          category: map['category'],
          roadAddress: map['roadAddress'],
        );

  /// 객체를 Map 형식의 json 데이터로 변환
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'link': link,
      'category': category,
      'roadAddress': roadAddress,
    };
  }

  @override
  String toString() {
    return 'title: $title, link: $link, category: $category, roadAddress: $roadAddress';
  }
}
