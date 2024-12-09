import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HomePageBottomsheet extends StatefulWidget {
  List<String> searchTerms;
  HomePageBottomsheet(this.searchTerms);

  @override
  State<HomePageBottomsheet> createState() => _HomePageBottomsheetState();
}

class _HomePageBottomsheetState extends State<HomePageBottomsheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(
            text: '최근 검색 기록\n',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
            children: createTextSpans(widget.searchTerms),
          ),
        ),
      ),
    );
  }

  /// 검색 기록 텍스트 추가
  List<TextSpan> createTextSpans(List<String> arrayStrings) {
    List<TextSpan> arrayOfTextSpan = [];
    for (int index = 0; index < arrayStrings.length; index++) {
      String text = arrayStrings[index];
      final span = TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
        recognizer: TapGestureRecognizer()
          ..onTap = () => print("The word touched is ${arrayStrings[index]}"),
        children: <InlineSpan>[
          WidgetSpan(
            child: GestureDetector(
              onTap: () {
                // TODO: 최근 검색 기록 삭제
                print('최근 검색 기록 삭제 클릭');
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 2),
                child: Icon(
                  key: Key(text),
                  Icons.close,
                  size: 18,
                ),
              ),
            ),
          ),
          WidgetSpan(child: SizedBox(width: 5)),
        ],
      );
      arrayOfTextSpan.add(span);
      // 더보기
      if (index == 3) {
        final more = TextSpan(
          text: '\n...더 보기',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              // TODO: 검색 기록 페이지 이동
              print("더 보기 클릭");
            },
        );
        arrayOfTextSpan.add(more);
        break;
      }
    }
    return arrayOfTextSpan;
  }
}
