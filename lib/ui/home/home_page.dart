import 'package:flutter/material.dart';
import 'package:local_search_app/ui/detail/detail_page.dart';

class HomePage extends StatelessWidget {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: '검색어를 입력해 주세요',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return item();
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 검색된 주소 아이템
  Padding item() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DetailPage();
              },
            ));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                // 테두리 둥글게
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  // 테두리 색상
                  color: Colors.grey[300]!,
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '삼성1동 주민센터',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '공공,사회기관>행정복지센터',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '서울특벽시 강남구 봉은사로 616 삼성1동 주민센터',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
